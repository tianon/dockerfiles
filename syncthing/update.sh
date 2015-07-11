#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

current="$(git ls-remote --tags https://github.com/syncthing/syncthing.git | grep -v '\^{}$' | grep -vE 'beta|rc' | cut -d/ -f3 | sort -V | tail -1)"
current="${current#v}"

set -x
sed -ri 's/^(ENV SYNCTHING_VERSION) .*/\1 '"$current"'/' Dockerfile
./inotify/update.sh
