#!/bin/bash
set -e

current="$(curl -sSL 'https://pypi.python.org/pypi/diffoscope/json' | awk -F '"' '$2 == "version" { print $4 }')"

set -x
sed -ri 's/^(ENV DIFFOSCOPE_VERSION) .*/\1 '"$current"'/' Dockerfile
