#!/usr/bin/env bash
set -Eeuo pipefail

suite="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' Dockerfile)"

version="$(
	wget -qO- "http://ppa.launchpad.net/lutris-team/lutris/ubuntu/dists/$suite/main/binary-amd64/Packages.xz" \
		| xz -d \
		| tac|tac \
		| gawk -F ':[[:space:]]+' '
			$1 == "Package" { pkg = $2 }
			$1 == "Version" && pkg == "lutris" { print $2; exit }
		'
)"

echo "lutris: $version"

sed -ri \
	-e 's!^(ENV LUTRIS_VERSION) .*!\1 '"$version"'!' \
	Dockerfile
