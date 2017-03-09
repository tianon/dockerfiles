#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

version="$(
	curl -fsSL 'https://repo.skype.com/deb/dists/stable/main/binary-amd64/Packages.gz' \
		| gunzip \
		| awk -F ': ' '$1 == "Package" { pkg = $2 } pkg == "skypeforlinux" && $1 == "Version" { print $2 }' \
		| head -1
)"

set -x
sed -ri 's!^(ENV SKYPE_VERSION) .*!\1 '"$version"'!' Dockerfile
