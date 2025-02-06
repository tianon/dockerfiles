#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"

# https://support.mozilla.org/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions
json="$(
	uri='http://packages.mozilla.org/apt'
	suite='mozilla'
	component='main'
	package='firefox' # TODO -beta? -nightly? -esr?
	deb-repo
)"

jq <<<"$json" '.' > versions.json
