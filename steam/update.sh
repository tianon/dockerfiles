#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

packages="$(wget -qO- 'https://repo.steampowered.com/steam/dists/precise/steam/binary-amd64/Packages')"

version="$(gawk -F ':[[:space:]]+' '$1 == "Package" { pkg = $2 } pkg == "steam-launcher" && $1 == "Version" { print $2; exit }' <<<"$packages")"
[ -n "$version" ]
sha256="$(gawk -F ':[[:space:]]+' '$1 == "Package" { pkg = $2 } pkg == "steam-launcher" && $1 == "SHA256" { print $2; exit }' <<<"$packages")"
[ -n "$sha256" ]

version="${version##*:}"

echo "steam: $version ($sha256)"

sed -ri \
	-e 's!^(ENV STEAM_VERSION) .*!\1 '"$version"'!' \
	-e 's!^(ENV STEAM_SHA256) .*!\1 '"$sha256"'!' \
	Dockerfile
