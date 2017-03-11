#!/bin/bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry

# TODO add version tags for media-server versions
tagsEntry "$dir/media-server" media-server
