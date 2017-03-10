#!/bin/bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry
env="${dir^^}_VERSION"
env="${env//-/_}"
versionedEnvTagsEntry "$dir" "$env" latest

# TODO add version tags for node-exporter versions
tagsEntry "$dir/node-exporter" node-exporter
