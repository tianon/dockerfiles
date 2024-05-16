#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

version="$(jq -r '.version' "$dir/versions.json")"
# TODO from="$(awk '$1 == "FROM" { from = $3 } END { print from }' "$dir/Dockerfile")" # TODO multi-stage build more intelligently 😬
from='infosiftr/moby'
arches="$(bashbrew remote arches --json "$from" | jq -r '.arches | keys | join(", ")')"

source gsl-libs.sh

globalEntry
echo "Architectures: $arches"

versionedTagsEntry "$dir" "$version" latest
