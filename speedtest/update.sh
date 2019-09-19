#!/usr/bin/env bash
set -Eeuo pipefail

current="$(curl -sSL 'https://pypi.python.org/pypi/speedtest-cli/json' | jq .info.version | tr -d '"')"

set -x
sed -ri 's/^(ENV SPEEDTEST_VERSION) .*/\1 '"$current"'/' Dockerfile
