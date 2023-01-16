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

# TODO add version tags for alertmanager / exporters
variantAppendOrder='prefix'
versionedEnvVariantEntry "$dir/alertmanager" alertmanager ALERTMANAGER_VERSION alertmanager
tagsEntry "$dir/blackbox-exporter" blackbox-exporter
tagsEntry "$dir/node-exporter" node-exporter
