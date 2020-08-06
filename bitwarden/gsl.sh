#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry

variantAppendOrder='prefix'

versionedEnvVariantEntry "$dir/cli" cli 'BITWARDEN_VERSION' cli
