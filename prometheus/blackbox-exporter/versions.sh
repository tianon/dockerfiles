#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

_source() {
	local dir
	dir="$(readlink -ve "$BASH_SOURCE")"
	dir="$(dirname "$dir")"
	source "$dir/../hooks.sh"
	source "$dir/../../.libs/git.sh"
}
_source

json="$(git-tags 'https://github.com/prometheus/blackbox_exporter.git')"

jq <<<"$json" '.' > versions.json
