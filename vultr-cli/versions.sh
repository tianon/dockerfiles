#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

json="$(
	hook_vultr-sha256() {
		local tag
		tag="$(jq <<<"$json" -r '.tag')" || return "$?"

		local checksums
		checksums="$(wget -qO- "https://github.com/vultr/vultr-cli/releases/download/$tag/vultr-cli_v${version}_checksums.txt")" || return "$?"

		jq <<<"$checksums" -sR '
			rtrimstr("\n")
			| split("\n")
			| map(capture("^(?<sha256>[0-9a-f]{64})(  | [*])(?<file>.*)$"))
			| reduce .[] as $i ({}; .[$i.file] = $i.sha256)
			| { sha256: . }
			# TODO urls?
		' || return "$?"
	}
	versions_hooks+=( hook_vultr-sha256 )
	git-tags 'https://github.com/vultr/vultr-cli.git'
)"

jq <<<"$json" '.' > versions.json
