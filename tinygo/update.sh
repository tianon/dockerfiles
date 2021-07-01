#!/usr/bin/env bash
set -Eeuo pipefail

latest="$(git ls-remote --tags https://github.com/tinygo-org/tinygo.git | cut -d/ -f3 | cut -d^ -f1 | sort -V | tail -1)"
latest="${latest#v}"

dir="$(dirname "$BASH_SOURCE")"
set -x
sed -ri \
	-e 's/^(ENV TINYGO_VERSION) .*/\1 '"$latest"'/' \
	"$dir/Dockerfile"
