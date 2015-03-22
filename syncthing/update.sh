#!/bin/bash
set -e

current="$(git ls-remote --tags https://github.com/syncthing/syncthing.git | grep -v '\^{}$' | grep -v beta | cut -d/ -f3 | sort -V | tail -1)"
current="${current#v}"

set -x
sed -ri 's/^(ENV SYNCTHING_VERSION) .*/\1 '"$current"'/' Dockerfile
