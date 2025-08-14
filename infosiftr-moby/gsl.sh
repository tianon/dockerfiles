#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

version="$(jq -r '.version' "$dir/versions.json")"
[ -n "$version" ]

from="$(awk '$1 == "FROM" { print $2; exit }' "$dir/Dockerfile")" # TODO multi-stage build??
arches="$(bashbrew remote arches --json "$from" | jq -c '.arches | keys + ["mips64le"]')"
archesString="$(jq <<<"$arches" -r 'join(", ")')"
[ -n "$archesString" ]

source gsl-libs.sh
extraCommitFiles=( Dockerfile.bookworm )

globalEntry
echo "Architectures: $archesString"

versionedTagsEntry "$dir" "$version" latest
echo 'mips64le-File: Dockerfile.bookworm'

# add old per-arch tags: https://explore.ggcr.dev/?repo=infosiftr/moby
archArr="$(jq <<<"$arches" -r 'map(@sh) | join(" ")')"
eval "archArr=( $archArr )"
for arch in "${archArr[@]}"; do
	tagsEntry "$dir" "$arch"
	echo "Architectures: $arch"
	if [ "$arch" = 'mips64le' ]; then
		echo 'mips64le-File: Dockerfile.bookworm'
	fi
done
