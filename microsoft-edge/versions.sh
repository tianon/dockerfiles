#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"

channel="$(basename "$PWD")" # "dev", etc

json="$(
	uri='https://packages.microsoft.com/repos/edge'
	suite='stable'
	component='main'
	package="microsoft-edge-$channel"
	deb-repo
)"

jq <<<"$json" '.' > versions.json
