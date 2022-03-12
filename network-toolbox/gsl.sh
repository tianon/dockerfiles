#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

dir="$(basename "$PWD")"

suite="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' debian/Dockerfile)"
suite="${suite%-slim}"

alpine="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' alpine/Dockerfile)"

cd ..

source gsl-libs.sh

globalEntry
tagsEntry "$dir/alpine" alpine "alpine$alpine"
tagsEntry "$dir/debian" debian "$suite" latest
