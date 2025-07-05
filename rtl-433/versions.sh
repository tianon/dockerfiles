#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

json="$(
	hook_no-nightly() {
		case "$3" in
			'nightly') return 1 ;;
			'master') return 1 ;; # this is diabolical (I'm not sure if it was a mistake or intentional, but they pushed a tag named "master")
		esac
	}
	versions_hooks+=( hook_no-nightly )
	git-tags 'https://github.com/merbanan/rtl_433.git'
)"

jq <<<"$json" '.' > versions.json
