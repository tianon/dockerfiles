#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

current="$(git ls-remote --tags https://github.com/nylas/N1.git | cut -d/ -f3 | sort -V | tail -1)"

set -x
sed -ri 's/^(ENV N1_VERSION) .*/\1 '"$current"'/' Dockerfile
