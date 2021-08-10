#!/usr/bin/env bash
set -Eeuo pipefail

suite="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' Dockerfile)"

ppaVersion="$(
	# https://launchpad.net/~lutris-team/+archive/ubuntu/lutris
	wget -qO- "http://ppa.launchpad.net/lutris-team/lutris/ubuntu/dists/$suite/main/binary-amd64/Packages.xz" \
		| xz -d \
		| tac|tac \
		| gawk -F ':[[:space:]]+' '
			$1 == "Package" { pkg = $2 }
			$1 == "Version" && pkg == "lutris" { print $2; exit }
		'
)"
tilde='~'
version="${ppaVersion%$tilde*}"

echo "lutris: $version ($ppaVersion)"

sed -ri \
	-e 's!^(ENV LUTRIS_VERSION) .*!\1 '"$version"'!' \
	-e 's!^(ENV LUTRIS_PPA_VERSION) .*!\1 '"$ppaVersion"'!' \
	Dockerfile
