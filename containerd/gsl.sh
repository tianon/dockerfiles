#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

version="$(jq -r '.version' "$dir/versions.json")"

source gsl-libs.sh

globalEntry

versionedTagsEntry "$dir" "$version" latest
dockerfile='Dockerfile.c8dind' versionedVariantEntry "$dir" c8dind "$version" c8dind
