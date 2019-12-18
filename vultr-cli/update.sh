#!/usr/bin/env bash
set -Eeuo pipefail

latest="$(git ls-remote --tags https://github.com/vultr/vultr-cli.git | cut -d/ -f3 | cut -d^ -f1 | sort -V | tail -1)"
latest="${latest#v}"

sha256="$(wget -qO- "https://github.com/vultr/vultr-cli/releases/download/v${latest}/vultr-cli_v${latest}_checksums.txt" | grep -E '_linux_64-bit[.]tar[.]gz$' | cut -d' ' -f1)"

dir="$(dirname "$BASH_SOURCE")"
set -x
sed -ri \
	-e 's/^(ENV VULTR_CLI_VERSION) .*/\1 '"$latest"'/' \
	-e 's/^(ENV VULTR_CLI_SHA256) .*/\1 '"$sha256"'/' \
	"$dir/Dockerfile"
