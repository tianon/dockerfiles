#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

# https://github.com/landley/toybox/issues/493
hook_pin_version='0.8.10'
versions_hooks+=( hook_pin-version )

json="$(git-tags 'https://github.com/landley/toybox.git')"

jq <<<"$json" '.' > versions.json
