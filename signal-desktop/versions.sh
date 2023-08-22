#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"

channel="$(basename "$PWD")" # "dev", etc

json="$(
	uri='https://updates.signal.org/desktop/apt'
	suite='xenial'
	component='main'
	package='signal-desktop'
	deb-repo
)"

jq <<<"$json" '.' > versions.json
