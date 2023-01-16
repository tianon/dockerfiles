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

variantAppendOrder='prefix'
versionedEnvVariantEntry "$dir/alertmanager" alertmanager ALERTMANAGER_VERSION alertmanager
versionedEnvVariantEntry "$dir/blackbox-exporter" blackbox-exporter BLACKBOX_EXPORTER_VERSION blackbox-exporter
versionedEnvVariantEntry "$dir/node-exporter" node-exporter NODE_EXPORTER_VERSION node-exporter
