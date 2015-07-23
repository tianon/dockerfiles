#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

url="$(curl -fsSL 'https://plex.tv/downloads' | grep '_amd64.deb".*Ubuntu' | cut -d'"' -f2)"

set -x
sed -ri 's!^(ENV PLEX_URL) .*!\1 '"$url"'!' Dockerfile
