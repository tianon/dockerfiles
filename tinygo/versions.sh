#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

json="$(git-tags 'https://github.com/tinygo-org/tinygo.git')"
tag="$(jq <<<"$json" -r '.tag')"
go="$(
	wget -qO- "https://github.com/tinygo-org/tinygo/raw/$tag/go.mod" \
		| awk '$1 == "go" { print $2; exit }'
)"
echo "tinygo go: $go"

jq <<<"$json" -S --arg go "$go" 'del(.tag) | .go = { version: $go }' > versions.json
