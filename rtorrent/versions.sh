#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

#versions_hooks+=( hook_no-prereleases )

json="$(
	hook_rtorrent() {
		local tag
		tag="$(jq <<<"$json" -r '.tag')" || return "$?"

		wget -qO- "https://github.com/rakshasa/rtorrent/releases/expanded_assets/$tag" \
			| jq --raw-input --slurp '
				[
					capture("(?x)
						[[:space:]>\"]
						( # filename
							(?<key> libtorrent | rtorrent )
							-
							[0-9.-]+
							[.]tar[.]gz
						)
						[[:space:]<\"]
						.*?
						sha256:(?<value>[0-9a-f]{64})
						[^0-9a-f]
					"; "g")
				]
				| from_entries
				| if has("libtorrent") and has("rtorrent") then . else
					error("missing one of libtorrent or rtorrent: \(.)")
				end
				| { components: . }
			'
	}
	versions_hooks+=( hook_rtorrent )
	git-tags 'https://github.com/rakshasa/rtorrent.git'
)"

jq <<<"$json" '.' > versions.json
