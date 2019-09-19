#!/usr/bin/env bash
set -Eeuo pipefail

current="$(curl -fsSL 'https://pypi.python.org/pypi/speedtest-cli/json' | jq -r '.info.version')"

set -x
sed -ri 's/^(ENV SPEEDTEST_VERSION) .*/\1 '"$current"'/' Dockerfile
