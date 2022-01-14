#!/usr/bin/env bash
set -Eeuo pipefail

version="$(
	git ls-remote --tags https://github.com/HandBrake/HandBrake.git \
		| cut -d/ -f3 \
		| cut -d^ -f1 \
		| sort -V \
		| tail -1
)"

echo "handbrake: $version"

sed -ri \
	-e 's!^(ENV HANDBRAKE_VERSION) .*!\1 '"$version"'!' \
	Dockerfile
