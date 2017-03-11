#!/bin/bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry
tagsEntry "$dir/32" 32 latest
tagsEntry "$dir/64" 64
