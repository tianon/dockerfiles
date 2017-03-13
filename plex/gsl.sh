#!/bin/bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry

versionedEnvVariantEntry "$dir/media-server" media-server 'PLEX_VERSION' media-server
