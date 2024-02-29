#!/usr/bin/env bash
set -Eeuo pipefail

# TODO refactor this to create an oci-layout that we could just "crane push"

targetRepo='hell/win'
targetRegistry='https://registry-1.docker.io'
#targetRegistry='http://registry.docker:5000'

auth="$(jq -r '.auths."https://index.docker.io/v1/".auth' ~/.docker/config.json | base64 -d)"
[ -n "$auth" ]

token="$(curl -fsSL "https://$auth@auth.docker.io/token?service=registry.docker.io&scope=repository:$targetRepo:push,pull" | jq --raw-output '.token')"

curl_auth() {
	if [ -n "${token:-}" ]; then
		curl -H "Authorization: Bearer $token" "$@"
	else
		( set -x && curl "$@" )
	fi
}

curl_manifest() {
	curl -fsSL -H 'Accept: application/vnd.docker.distribution.manifest.v2+json' -H 'Accept: application/vnd.docker.distribution.manifest.list.v2+json' "$@"
}

# TODO "full" ???
for targetTag in core nano iot; do
	case "$targetTag" in
		core)
			# https://hub.docker.com/r/microsoft/windowsservercore
			sourceRepo='windows/servercore'
			sourceTags=( ltsc2022 20H2 2004 1909 1903 1809 1803 1709 1607 ltsc2019 ltsc2016 )
			;;

		nano)
			# https://hub.docker.com/r/microsoft/nanoserver
			sourceRepo='windows/nanoserver'
			sourceTags=( ltsc2022 20H2 2004 1909 1903 1809 1803 1709 sac2016 )
			;;

		iot)
			# https://hub.docker.com/_/microsoft-windows-iotcore
			sourceRepo='windows/iotcore'
			sourceTags=( 1809 )
			;;

		full) # TODO figure out WTF this is and whether "full" is really an appropriate name??  seems related to https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/gpu-acceleration but https://techcommunity.microsoft.com/t5/Containers/Windows-Server-2019-Now-Available/ba-p/382430 is the only announcement of it I can find...
			# https://www.thomasmaurer.ch/2018/06/new-windows-container-image/ !!!
			# https://docs.microsoft.com/en-us/virtualization/community/team-blog/2018/20180627-insider-preview-windows-container-image
			# https://hub.docker.com/_/microsoft-windows
			sourceRepo='windows'
			sourceTags=( 20H2 2004 1909 1903 1809 ltsc2019 )
			;;

		server) # TODO figure out WTF this is 😩
			# https://hub.docker.com/_/microsoft-windows-server
			sourceRepo='windows/server'
			sourceTags=( ltsc2022 )
			;;

		*)
			echo >&2 "error: WTF target tag '$targetTag'"
			exit 1
			;;
	esac
	export sourceRepo

	echo "processing $targetRepo:$targetTag"

	targetManifests='[]'
	for tag in "${sourceTags[@]}"; do
		echo "- pulling image mcr.microsoft.com/$sourceRepo:$tag"

		manifestList="$(curl_manifest "https://mcr.microsoft.com/v2/$sourceRepo/manifests/$tag")"

		manifestObjects=()
		mediaType="$(jq -r '.mediaType' <<<"$manifestList")"
		case "$mediaType" in
			application/vnd.docker.distribution.manifest.v2+json)
				# not a manifest list, so we need to fake a "manifest object" (with platform and digest)
				digest="$(echo -n "$manifestList" | sha256sum | cut -d' ' -f1)"
				digest="sha256:$digest"
				manifestObjects=( "$(jq -c --arg mediaType "$mediaType" --arg digest "$digest" --argjson size "${#manifestList}" '{ "mediaType": $mediaType, "digest": $digest, "size": $size }' -n)" )
				;;

			application/vnd.docker.distribution.manifest.list.v2+json)
				IFS=$'\n'
				manifestObjects=( $(jq -c '.manifests[]' <<<"$manifestList") )
				unset IFS
				;;

			*)
				echo >&2 "error: WTF tag '$tag' is media type '$mediaType'!"
				echo >&2 "$manifestList"
				exit 1
				;;
		esac
		[ "${#manifestObjects[@]}" -gt 0 ]

		for manifestObject in "${manifestObjects[@]}"; do
			digest="$(jq -r '.digest' <<<"$manifestObject")"

			echo "  - pulling manifest mcr.microsoft.com/$sourceRepo@$digest ..."

			manifest="$(curl_manifest "https://mcr.microsoft.com/v2/$sourceRepo/manifests/$digest")"

			# https://techcommunity.microsoft.com/t5/containers/announcing-removal-of-foreign-layers-from-windows-container/ba-p/3846833
			# we need to re-foreign ("deport") the now non-foreign layers
			manifest="$(jq -c '
				.layers |= map(
					if .mediaType == "application/vnd.docker.image.rootfs.diff.tar.gzip" then
						.mediaType = "application/vnd.docker.image.rootfs.foreign.diff.tar.gzip"
						| .urls = [ "https://mcr.microsoft.com/v2/" + env.sourceRepo + "/blobs/" + .digest ]
					else . end
				)
			' <<<"$manifest")"
			digest="$(printf '%s' "$manifest" | sha256sum | cut -d' ' -f1)"
			digest="sha256:$digest"
			manifestObject="$(jq --arg digest "$digest" --arg size "${#manifest}" -c '
				.digest = $digest
				| .size = ($size | tonumber)
			' <<<"$manifestObject")"
			echo "  - deported manifest ($digest)"

			[ -z "$(jq -r '.layers[].mediaType' <<<"$manifest" | grep -vE '^application/vnd.docker.image.rootfs.foreign.diff.tar.gzip$')" ] # sanity check (all layers should be foreign now)

			configDigest="$(jq -r '.config.digest' <<<"$manifest")"
			echo "    - pulling config ($configDigest)"

			config="$(curl -fsSL "https://mcr.microsoft.com/v2/$sourceRepo/blobs/$configDigest")"

			echo "    - pushing config"

			fack="$(curl_auth -X POST "$targetRegistry/v2/$targetRepo/blobs/uploads/" -fsSL -D- | tr -d '\r')"
			loc="$(grep -i 'Location:' <<<"$fack" | sed -r 's/^.+:[[:space:]]+//')"
			[ -n "$loc" ]
			curl_auth -fsSL -X PUT -H 'Content-Type: application/octet-stream' --data-raw "$config" "$loc&digest=$configDigest" -fsSL

			echo "    - pushing manifest"

			curl_auth -X PUT -H "Content-Type: $(jq -r '.mediaType' <<<"$manifest")" --data-raw "$manifest" "$targetRegistry/v2/$targetRepo/manifests/$digest" -fsSL

			platform="$(jq '.platform // empty' <<<"$manifestObject")"
			if [ -z "$platform" ]; then
				platform="$(jq '{ "os": .os, "architecture": .architecture, "os.version": ."os.version" }' <<<"$config")"
				manifestObject="$(jq --argjson platform "$platform" '. + {"platform": $platform}' <<<"$manifestObject")"
				echo "      faked platform: $(jq -cS '.' <<<"$platform")"
			else
				echo "      platform: $(jq -cS '.' <<<"$platform")"
			fi

			targetManifests="$(jq --argjson list "$targetManifests" --argjson new "$manifestObject" -n '$list + [$new]')"
		done
	done

	targetManifest='{
		"schemaVersion": 2,
		"mediaType": "application/vnd.docker.distribution.manifest.list.v2+json",
		"manifests": '"$targetManifests"'
	}'
	targetManifest="$(jq -S . <<<"$targetManifest")"

	echo "- pushing $targetRepo:$targetTag"

	curl_auth -X PUT -H "Content-Type: $(jq -r '.mediaType' <<<"$targetManifest")" --data-raw "$targetManifest" "$targetRegistry/v2/$targetRepo/manifests/$targetTag" -fsSL

	echo
done
