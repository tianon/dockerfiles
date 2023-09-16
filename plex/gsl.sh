#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry

versionedEnvVariantEntry "$dir/media-server" media-server 'PLEX_VERSION' media-server
from="$(awk '$1 == "FROM" { print $2; exit }' "$dir/media-server/Dockerfile")" # TODO multi-stage build??
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
' "$dir/media-server/versions.json")"
[ -n "$arches" ]
echo "Architectures: $arches"
