#!/bin/bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry
env='DOCKER_VERSION'
versionedEnvTagsEntry "$dir" "$env" latest master
versionedEnvSubvariantEntry "$dir" "$env" dind dind master-dind
versionedEnvSubvariantEntry "$dir" "$env" git git master-git
