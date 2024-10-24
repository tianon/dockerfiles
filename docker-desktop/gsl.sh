#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry
env="${dir^^}_VERSION"
env="${env//-/_}"
versionedEnvTagsEntry "$dir" "$env" latest
echo '# ironically, this cannot use BuildKit: https://github.com/moby/buildkit/issues/1267'
echo 'Builder: classic'
