#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

moby="$(git-ref-commit 'https://github.com/moby/moby.git' 'HEAD')"
cli="$(git-ref-commit 'https://github.com/docker/cli.git' 'HEAD')"
buildx="$(git-ref-commit 'https://github.com/docker/buildx.git' 'HEAD')"

moby="$(
	commit="$(jq <<<"$moby" -r '.version')"
	go="$(wget -qO- "https://github.com/moby/moby/raw/$commit/vendor.mod")"
	go="$(awk <<<"$go" '$1 == "go" { print $2; exit }')"
	echo >&2 "moby go: $go"
	jq <<<"$moby" -c --arg go "$go" '.go = { version: $go }'
)"

cli="$(
	commit="$(jq <<<"$cli" -r '.version')"
	go="$(wget -qO- "https://github.com/docker/cli/raw/$commit/vendor.mod")"
	go="$(awk <<<"$go" '$1 == "go" { print $2; exit }')"
	echo >&2 "cli go: $go"
	jq <<<"$cli" -c --arg go "$go" '.go = { version: $go }'
)"

buildx="$(
	commit="$(jq <<<"$buildx" -r '.version')"
	go="$(wget -qO- "https://github.com/docker/buildx/raw/$commit/go.mod")"
	go="$(awk <<<"$go" '$1 == "go" { print $2; exit }')"
	echo >&2 "buildx go: $go"
	jq <<<"$buildx" -c --arg go "$go" '.go = { version: $go }'
)"

jq <<<"$moby" --argjson cli "$cli" --argjson buildx "$buildx" '
	. += {
		cli: $cli,
		buildx: $buildx,
	}
' > versions.json
