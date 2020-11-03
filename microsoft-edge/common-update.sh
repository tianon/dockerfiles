#!/usr/bin/env bash
set -Eeuo pipefail

channel="$(basename "$PWD")" # "dev", etc

version="$(
	wget -qO- 'https://packages.microsoft.com/repos/edge/dists/stable/main/binary-amd64/Packages.gz' \
		| gunzip \
		| tac|tac \
		| gawk -F ':[[:space:]]+' -v channel="$channel" '
			$1 == "Package" { pkg = $2 }
			$1 == "Version" && pkg == "microsoft-edge-" channel { print $2; exit }
		'
)"

echo "microsoft-edge-$channel: $version"
[ -n "$version" ]

sed -ri \
	-e 's!^(ENV EDGE_VERSION) .*!\1 '"$version"'!' \
	Dockerfile
