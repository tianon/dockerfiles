#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

version="$(jq -r '.version' "$dir/versions.json")"
[ -n "$version" ]

from="$(awk '$1 == "FROM" { print $2; exit }' "$dir/Dockerfile")" # TODO multi-stage build??
arches="$(bashbrew remote arches --json "$from" | jq -r '.arches | keys + ["riscv64"] | join(", ")')"
[ -n "$arches" ]

source gsl-libs.sh

globalEntry
echo "Architectures: $arches"

versionedTagsEntry "$dir" "$version" latest
echo 'riscv64-File: Dockerfile.unstable'
