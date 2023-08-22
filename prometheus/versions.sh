#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

_source() {
	local dir
	dir="$(readlink -ve "$BASH_SOURCE")"
	dir="$(dirname "$dir")"
	source "$dir/hooks.sh"
	source "$dir/../.libs/git.sh"
}
_source

json="$(
	hook_prometheus-noretractnoplus() {
		case "$3" in
			*-retract | *+*) return 1 ;;
		esac
	}
	versions_hooks+=( hook_prometheus-noretractnoplus )

	git-tags 'https://github.com/prometheus/prometheus.git'
)"

jq <<<"$json" '.' > versions.json
