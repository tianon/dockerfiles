#!/usr/bin/env bash
set -Eeuo pipefail

list="$(jq --raw-output --null-input '
	include "./multiarch";
	platforms
	| map(@json | @sh)
	| join(" ")
')"
eval "platforms=( $list )"

export PATH="$PATH:$HOME/docker/bin/jq-oci" # TODO asdflkjoasdfhasdhfkljasdjfklasdf

mkdir -p multiarch
cd multiarch

oci-init

for platform in "${platforms[@]}"; do
	config="$(jq <<<"$platform" --tab '
		debug # status output - which platform we are parsing 😂
		| .history = []
		| .rootfs.type = "layers"
	' | oci-put)"
	configData="$(oci-get <<<"$config" | base64 --wrap=0)"
	manifest="$(configData="$configData" jq <<<"$config" --tab --argjson platform "$platform" '
		{
			schemaVersion: 2,
			mediaType: "application/vnd.oci.image.manifest.v1+json",
			config: ({ mediaType: "application/vnd.oci.image.config.v1+json" } * . * { platform: $platform, data: env.configData }),
		}
	' | oci-put)"
	jq --tab --argjson manifest "$manifest" --argjson platform "$platform" '
		.manifests += [ { mediaType: "application/vnd.oci.image.manifest.v1+json" } * $manifest * { platform: $platform } ]
	' index.json > index.json.new
	mv index.json.new index.json
done
