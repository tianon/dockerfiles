#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )
hook_missing-deb() {
	local version="$3"
	local debVer="${version//-/_}"; \
	wget -q -O /dev/null --spider "https://github.com/lutris/lutris/releases/download/v${version}/lutris_${debVer}_all.deb"
}
versions_hooks+=( hook_missing-deb )

json="$(git-tags 'https://github.com/lutris/lutris.git')"

jq <<<"$json" '.' > versions.json
