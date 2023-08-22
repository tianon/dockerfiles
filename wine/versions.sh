#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"

suite="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' Dockerfile.template)"
suite="${suite%-slim}"

json="$(
	uri='https://dl.winehq.org/wine-builds/debian'
	component='main'
	package='winehq-stable'
	deb-repo
)"

jq <<<"$json" '
	{
		version: (.version | split("~")[0]),
		debian: .,
	}
' > versions.json
