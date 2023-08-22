#!/usr/bin/env bash
set -Eeuo pipefail

_source() {
	local dir
	dir="$(readlink -ve "$BASH_SOURCE")"
	dir="$(dirname "$dir")"
	source "$dir/../.libs/hooks.sh"
}
_source

versions_hooks+=( hook_no-prereleases )

hook_prometheus-sha256() {
	[ "$1" = 'git' ] || return 0
	[[ "$2" == github.com/prometheus/* ]] || return 0

	local tag
	tag="$(jq <<<"$4" -r '.tag')" || return "$?"

	local sha256sums
	sha256sums="$(wget -qO- "https://$2/releases/download/$tag/sha256sums.txt")" || return "$?"

	jq <<<"$sha256sums" -sR '
		rtrimstr("\n")
		| split("\n")
		| map(capture("^(?<sha256>[0-9a-f]{64})(  | [*])(?<file>.*)$"))
		| reduce .[] as $i ({}; .[$i.file] = $i.sha256)
		| { sha256: . }
		# TODO urls?
	' || return "$?"
}
versions_hooks+=( hook_prometheus-sha256 )
