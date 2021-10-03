#!/usr/bin/env bash
set -Eeuo pipefail

suite="$(gawk -F '[[:space:]:-]+' '$1 == "FROM" { print $3; exit }' Dockerfile)"

fullVersion="$(
	# https://wiki.winehq.org/Debian
	# https://dl.winehq.org/wine-builds/debian/dists/bullseye/main/binary-amd64/?C=N;O=D
	wget -qO- "https://dl.winehq.org/wine-builds/debian/dists/$suite/main/binary-amd64/Packages.xz" \
		| xz -d \
		| tac|tac \
		| gawk -F ':[[:space:]]+' '
			$1 == "Package" { pkg = $2 }
			$1 == "Version" && pkg == "winehq-stable" { print $2 }
		' \
		| sort -rV \
		| head -1
)"
tilde='~'
version="${fullVersion%$tilde*}"

echo "wine: $version ($fullVersion)"

sed -ri \
	-e 's!^(ENV WINE_VERSION) .*!\1 '"$version"'!' \
	-e 's!^(ENV WINE_DEB_VERSION) .*!\1 '"$fullVersion"'!' \
	Dockerfile
