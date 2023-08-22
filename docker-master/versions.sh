#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

moby="$(git-ref-commit 'https://github.com/moby/moby.git' 'HEAD')"
cli="$(git-ref-commit 'https://github.com/docker/cli.git' 'HEAD')"
buildx="$(git-ref-commit 'https://github.com/docker/buildx.git' 'HEAD')"

jq <<<"$moby" --argjson cli "$cli" --argjson buildx "$buildx" '
	. += {
		cli: $cli,
		buildx: $buildx,
	}
' > versions.json
