#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry

versionedEnvVariantEntry "$dir/beta" beta 'EDGE_VERSION' beta
versionedEnvVariantEntry "$dir/dev" dev 'EDGE_VERSION' dev
