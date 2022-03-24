#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry

# TODO !!!!! switch to File: with the new variants 🙈
versionedEnvTagsEntry "$dir/weekly" 'JENKINS_VERSION' weekly latest
versionedEnvVariantEntry "$dir/lts" lts 'JENKINS_VERSION' lts
