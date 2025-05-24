#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../../.libs/git.sh"

json="$(git-tags 'https://github.com/wiedehopf/readsb.git')"

jq <<<"$json" . > versions.json
