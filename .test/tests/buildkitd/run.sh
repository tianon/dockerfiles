#!/usr/bin/env bash
set -Eeuo pipefail

image="$1"

# mimic https://github.com/docker-library/official-images/blob/09efb10abd3214d02ad9a502b7358797acf486a8/.bin/docker-buildx-ensure.sh (since it's the primary user of tianon/buildkit)

builderName='tianon-test-buildkit'
tmp=
trap 'docker buildx rm --force "$builderName" || :; docker rmi "$builderName" &> /dev/null || :; [ -n "$tmp" ] && rm -rf "$tmp" || :' EXIT

config='
	# https://github.com/moby/buildkit/blob/v0.11.4/docs/buildkitd.toml.md
	[worker.oci]
		gc = false
	[worker.containerd]
		gc = false
'

image="$(docker image inspect --format '{{ .ID }}' "$image")"

args=(
	--name "$builderName"
	--node "$builderName"
	--driver docker-container
	--driver-opt image="$image"
	--bootstrap
)
docker buildx create "${args[@]}" --config <(printf '%s' "$config") # cleaned up in 'trap' above

docker buildx build --builder "$builderName" --load --tag "$builderName" - <<<'FROM hello-world'
docker run --rm "$builderName"
docker rmi "$builderName"
docker buildx prune --builder "$builderName" --all --force

# now that we've got the basic stuff out of the way, let's test the image's ability to transparently be a frontend instead
tmp="$(mktemp -d)" # cleaned up in 'trap' above
# https://github.com/tianon/docker-bin/blob/master/docker-save-oci-layout.sh
saveMe='https://github.com/tianon/docker-bin/raw/67e6dbb725b3df2def1ac74820b61d9cefedc090/docker-save-oci-layout.sh'
saveMeSha='baca98f706f58f6be5c327ce9b3ab7290b917b31dd7b354d397d28d2ce6fff97'
wget -qO "$tmp/save.sh" "$saveMe"
sha256sum <<<"$saveMeSha *$tmp/save.sh" --strict --check --quiet -
chmod +x "$tmp/save.sh"
"$tmp/save.sh" "$tmp" "$image"

docker buildx build --builder "$builderName" --load --tag "$builderName" --build-arg BUILDKIT_SYNTAX='foo' --build-context "foo=oci-layout://$tmp" - <<<'FROM hello-world'
docker run --rm "$builderName"
docker rmi "$builderName"
docker buildx prune --builder "$builderName" --all --force
