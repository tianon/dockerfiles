#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

version="$(curl -fsSL 'https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&channel=16&distro=ubuntu' | sed -n 's/.*Release.*version="\([^"]*\)".*/\1/p')"

set -x
sed -ri 's!^(ENV PLEX_VERSION) .*!\1 '"$version"'!' Dockerfile
