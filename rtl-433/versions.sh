#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

json="$(
	hook_no-nightly() { [ "$3" != 'nightly' ]; }
	versions_hooks+=( hook_no-nightly )
	git-tags 'https://github.com/merbanan/rtl_433.git'
)"

jq <<<"$json" '.' > versions.json
