#!/usr/bin/env bash
set -Eeuo pipefail

suite="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' Dockerfile)"
suite="${suite%-slim}"

version="$(
	wget -qO- "https://weechat.org/debian/dists/$suite/main/binary-amd64/Packages.gz" \
		| gunzip \
		| tac|tac \
		| gawk -F ':[[:space:]]+' '
			$1 == "Package" { pkg = $2 }
			$1 == "Version" && pkg == "weechat" { print $2; exit }
		'
)"

echo "weechat: $version"

sed -ri \
	-e 's!^(ENV WEECHAT_VERSION) .*!\1 '"$version"'!' \
	Dockerfile
