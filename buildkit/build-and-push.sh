#!/usr/bin/env bash
set -Eeuo pipefail

version="$(awk '$1 == "ENV" && $2 == "BUILDKIT_VERSION" { print $3; exit }' Dockerfile)"
[ -n "$version" ]
[[ "$version" == *.* ]] # at least one period so we can strip it for a tag
args=(
	--tag "tianon/buildkit:$version" # 1.2.3
	--tag "tianon/buildkit:${version%.*}" # 1.2
	--tag 'tianon/buildkit:latest'

	--pull
	--platform linux/amd64,linux/386,linux/arm64/v8,linux/arm/v7,linux/arm/v5,linux/mips64le,linux/ppc64le,linux/riscv64,linux/s390x,linux/arm/v6 # TODO actual v6? (this is v5 pretending to be v6 🙈)
	--push
	--provenance mode=max

	--annotation "index:org.opencontainers.image.version=$version"
	--annotation "manifest-descriptor:org.opencontainers.image.version=$version"
	--annotation "manifest:org.opencontainers.image.version=$version"

	.
)

set -x
exec docker buildx build "${args[@]}"
