#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

current="$(curl -fsSL 'https://pypi.org/pypi/certbot/json' | jq -r .info.version)"

set -x
sed -ri 's/^(ENV CERTBOT_VERSION) .*/\1 '"$current"'/' Dockerfile
