#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry

variantAppendOrder='prefix'

versionedEnvVariantEntry "$dir/readsb" readsb 'READSB_VERSION' readsb
from="$(awk '$1 == "FROM" { print $2; exit }' "$dir/readsb/Dockerfile")" # TODO multi-stage build??
fromArches="$(bashbrew remote arches --json "$from" | jq -rc '.arches | keys | join(", ")')"
echo "Architectures: $fromArches"
