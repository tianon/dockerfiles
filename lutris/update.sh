#!/usr/bin/env bash
set -Eeuo pipefail

version="$(
	git ls-remote --tags https://github.com/lutris/lutris.git \
		| sed \
			-e 's!^.*/!!' \
			-e 's/\^.*$//' \
			-e 's/^v//' \
		| sort -ruV \
		| grep -vE 'beta' \
		| head -1
)"

echo "lutris: $version"

sed -ri \
	-e 's!^(ENV LUTRIS_VERSION) .*!\1 '"$version"'!' \
	Dockerfile
