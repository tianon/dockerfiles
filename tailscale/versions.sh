#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

json="$(
	hook_tailscale-static() {
		wget -qO/dev/null "https://pkgs.tailscale.com/stable/tailscale_${version}_amd64.tgz.sha256" || return "$?"
		# TODO download/save/embed all the checksums
	}
	versions_hooks+=( hook_tailscale-static )
	git-tags 'https://github.com/tailscale/tailscale.git'
)"

jq <<<"$json" '.' > versions.json
