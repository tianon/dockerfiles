#!/bin/bash
set -e

current="$(curl -sSL 'https://pypi.python.org/pypi/gmvault/json' | awk -F '"' '$2 == "version" { print $4 }')"

set -x
sed -ri 's/^(ENV GMVAULT_VERSION) .*/\1 '"$current"'/' Dockerfile
