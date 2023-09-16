#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

dir="$(basename "$PWD")"

suite="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' debian/Dockerfile)"
suite="${suite%-slim}"

alpine="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' alpine/Dockerfile)"

cd ..

source gsl-libs.sh

globalEntry

tagsEntry "$dir/debian" debian "$suite" latest
from="$(awk '$1 == "FROM" { print $2; exit }' "$dir/debian/Dockerfile")" # TODO multi-stage build??
arches="$(bashbrew remote arches --json "$from" | jq -c '.arches | keys')"
archesString="$(jq <<<"$arches" -r 'join(", ")')"
[ -n "$archesString" ]
echo "Architectures: $archesString"

tagsEntry "$dir/alpine" alpine "alpine$alpine"
from="$(awk '$1 == "FROM" { print $2; exit }' "$dir/alpine/Dockerfile")" # TODO multi-stage build??
arches="$(bashbrew remote arches --json "$from" | jq -c '.arches | keys')"
archesString="$(jq <<<"$arches" -r 'join(", ")')"
[ -n "$archesString" ]
echo "Architectures: $archesString"
