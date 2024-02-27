#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry
tagsEntry "$dir" latest

# TODO Architectures
dockerfile='Dockerfile.nolibc'
from="$(awk '$1 == "FROM" { print $2; exit }' "$dir/$dockerfile")" # TODO multi-stage build?? (scratch does not count)
arches="$(bashbrew remote arches --json "$from" | jq -c '.arches | keys | join(", ")' -r)"
tagsEntry "$dir" nolibc
echo "Architectures: $arches"
