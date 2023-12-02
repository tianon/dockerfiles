#!/usr/bin/env bash
set -Eeuo pipefail

image="$1"

# mimic https://github.com/docker-library/official-images/blob/09efb10abd3214d02ad9a502b7358797acf486a8/.bin/docker-buildx-ensure.sh (since it's the user of tianon/buildkit)

builderName='tianon-test-buildkit'
trap 'docker buildx rm --force "$builderName" || :' EXIT

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
docker buildx create "${args[@]}" --config <(printf '%s' "$config")

docker buildx build --builder "$builderName" --load --tag "$builderName" - <<<'FROM hello-world'
docker run --rm "$builderName"
docker rmi "$builderName"
