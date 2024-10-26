#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

json="$(git-tags 'https://github.com/tinygo-org/tinygo.git')"

tag="$(jq <<<"$json" -r '.tag')"

# parse https://github.com/tinygo-org/tinygo/blob/v0.34.0/builder/config.go#L27-L29 to get the "range" of Go versions supported
go="$(
	wget -qO- "https://github.com/tinygo-org/tinygo/raw/$tag/builder/config.go" \
		| jq -csR '
			[
				capture("((?<=\n)|^)[[:space:]]*const[[:space:]]+minor(?<key>Min|Max)[[:space:]]*=[[:space:]]*(?<value>[0-9]+)[[:space:]]*((?=\n)|$)"; "g")
				| .key |= ascii_downcase
				| .value |= { version: "1.\(.)" }
			]
			| from_entries
			| if has("min") and has("max") then . else
				error("failed to scrape either min or max from upstream")
			end
		'
)"
echo "tinygo go: $go"

jq <<<"$json" --argjson go "$go" '
	.go = $go
' > versions.json
