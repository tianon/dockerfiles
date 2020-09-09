#!/usr/bin/env bash
set -Eeuo pipefail

version="$(
	git ls-remote --tags https://github.com/landley/toybox.git \
		| cut -d/ -f3 \
		| cut -d^ -f1 \
		| sort -V \
		| tail -1
)"

echo "toybox: $version"

dir="$(dirname "$BASH_SOURCE")"

sed -ri -e 's/^(ENV TOYBOX_VERSION) .*/\1 '"$version"'/' "$dir/Dockerfile"
