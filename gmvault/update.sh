#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

current="$(curl -fsSL 'https://pypi.org/pypi/gmvault/json' | jq -r .info.version)"

set -x
sed -ri 's/^(ENV GMVAULT_VERSION) .*/\1 '"$current"'/' Dockerfile
