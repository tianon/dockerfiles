#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

version="$(jq -r '.version' "$dir/versions.json")"
from="$(awk '$1 == "FROM" { print $2; exit }' "$dir/Dockerfile")" # TODO multi-stage build??
fromArches="$(bashbrew remote arches --json "$from" | jq -c '.arches | keys')"
arches="$(jq -r -L "$dir/../.libs" --argjson fromArches "$fromArches" '
	include "lib"
	;
	[
		$fromArches,
		(.arches | map_values(select(.dpkgArch)) | keys),
		empty
	]
	| intersection
	| join(", ")
' "$dir/versions.json")"
[ -n "$arches" ]

source gsl-libs.sh

globalEntry
echo "Architectures: $arches"

versionedTagsEntry "$dir" "$version" latest
