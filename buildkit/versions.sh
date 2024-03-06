#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

json="$(
	json="$(git-tags 'https://github.com/moby/buildkit.git')"

	commit="$(jq <<<"$json" -r '.commit')"
	go="$(wget -qO- "https://github.com/moby/buildkit/raw/$commit/go.mod")"
	go="$(awk <<<"$go" '$1 == "go" { print $2; exit }')"
	echo >&2 "buildkit go: $go"
	jq <<<"$json" -c --arg go "$go" '.go = { version: $go }'
)"

jq <<<"$json" '.' > versions.json
