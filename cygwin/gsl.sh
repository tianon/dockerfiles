#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

variants="$(jq -r '.variants | map(@sh) | join(" ")' versions.json)"
eval "variants=( $variants )"

dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry

for variant in "${variants[@]}"; do
	dockerfile="Dockerfile.$variant"
	tagsEntry "$dir" "win$variant"
	cat <<-EOF
		Architectures: windows-amd64
		Constraints: windowsservercore-$variant
		SharedTags: latest
	EOF
done
