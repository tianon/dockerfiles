#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

current="$(curl -fsSL 'https://pypi.org/pypi/b2/json' | jq -r .info.version)"

set -x
sed -ri 's/^(ENV BACKBLAZE_B2_VERSION) .*/\1 '"$current"'/' Dockerfile
