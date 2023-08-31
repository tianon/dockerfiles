#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

json="$(git-tags 'https://github.com/tinygo-org/tinygo.git')"

tag="$(jq <<<"$json" -r '.tag')"
go="$(
	wget -qO- "https://github.com/tinygo-org/tinygo/raw/$tag/go.mod" \
		| awk '$1 == "go" { print $2; exit }'
)"
echo "tinygo go: $go"
# TODO this gives us the "minimal" version of Go, where it would be great if we could somehow parse https://github.com/tinygo-org/tinygo/blob/dc449882ad09c60c11cef7c35914d5fbfe22a88e/builder/config.go#L33 and get the "maximal" version instead

jq <<<"$json" --arg go "$go" '
	.go = { version: $go }
' > versions.json
