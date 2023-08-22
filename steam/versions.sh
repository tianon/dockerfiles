#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"

json="$(
	uri='https://repo.steampowered.com/steam'
	suite='precise'
	component='steam'
	package='steam-launcher'
	deb-repo
)"

jq <<<"$json" '.version |= split(":")[1]' > versions.json
