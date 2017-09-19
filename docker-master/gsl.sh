#!/bin/bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry
tagsEntry "$dir" latest master
tagsEntry "$dir/dind" dind master-dind
tagsEntry "$dir/git" git master-git
