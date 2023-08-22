#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"

suite="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' Dockerfile.template)"
suite="${suite%-slim}"

json="$(
	uri='https://weechat.org/debian'
	component='main'
	package='weechat'
	deb-repo
)"

jq <<<"$json" '.' > versions.json
