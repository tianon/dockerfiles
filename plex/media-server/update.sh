#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

#version="$(curl -fsSL 'https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&channel=16&distro=ubuntu' | sed -n 's/.*Release.*version="\([^"]*\)".*/\1/p')"

json="$(curl -fsSL 'https://plex.tv/api/downloads/1.json' | jq '.computer.Linux')"

version="$(echo "$json" | jq -r '.version')"

ubuntuRelease="$(echo "$json" | jq '.releases[] | select(.distro == "ubuntu" and .build == "linux-ubuntu-x86_64")')"
url="$(echo "$ubuntuRelease" | jq -r '.url')"
sha1="$(echo "$ubuntuRelease" | jq -r '.checksum')"

set -x
sed -ri \
	-e 's!^(ENV PLEX_VERSION) .*!\1 '"$version"'!' \
	-e 's!^(ENV PLEX_URL) .*!\1 '"$url"'!' \
	-e 's!^(ENV PLEX_SHA1) .*!\1 '"$sha1"'!' \
	Dockerfile
