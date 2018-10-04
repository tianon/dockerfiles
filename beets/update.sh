#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

current="$(curl -fsSL 'https://pypi.org/pypi/beets/json' | jq -r .info.version)"

set -x
sed -ri 's/^(ENV BEETS_VERSION) .*/\1 '"$current"'/' Dockerfile
