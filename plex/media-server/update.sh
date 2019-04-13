#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

#version="$(curl -fsSL 'https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&channel=16&distro=ubuntu' | sed -n 's/.*Release.*version="\([^"]*\)".*/\1/p')"

json="$(curl -fsSL 'https://plex.tv/api/downloads/1.json' | jq '.computer.Linux')"

version="$(jq -r '.version' <<<"$json")"

ubuntuRelease="$(jq '.releases[] | select(.distro == "debian" and .build == "linux-x86_64")' <<<"$json")"
url="$(jq -r '.url' <<<"$ubuntuRelease")"
sha1="$(jq -r '.checksum' <<<"$ubuntuRelease")"

set -x
sed -ri \
	-e 's!^(ENV PLEX_VERSION) .*!\1 '"$version"'!' \
	-e 's!^(ENV PLEX_URL) .*!\1 '"$url"'!' \
	-e 's!^(ENV PLEX_SHA1) .*!\1 '"$sha1"'!' \
	Dockerfile
