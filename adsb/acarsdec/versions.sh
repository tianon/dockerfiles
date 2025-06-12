#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../../.libs/git.sh"

json="$(git-tags 'https://github.com/TLeconte/acarsdec.git')"

libacars="$(git-tags 'https://github.com/szpajder/libacars.git')"

jq <<<"$json" --argjson libacars "$libacars" '
	.version |= ltrimstr("acarsdec-") # lol wtf
	| .libacars = $libacars
' > versions.json
