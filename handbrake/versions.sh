#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

# make sure the releases have published sources (difference between "tagged" and "released")
hook_hb-missing-source() {
	local version="$3"
	wget -q --spider "https://github.com/HandBrake/HandBrake/releases/download/$version/HandBrake-$version-source.tar.bz2.sig"
}

versions_hooks+=( hook_no-prereleases hook_hb-missing-source )

json="$(git-tags 'https://github.com/HandBrake/HandBrake.git')"

jq <<<"$json" '.' > versions.json
