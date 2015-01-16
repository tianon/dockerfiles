#!/bin/bash
set -e

if [ "$(id -u)" != 1000 -o "$(id -g)" != 1000 ]; then
	echo >&2 'uh, your UID and GID ought to be 1000, or permissions will likely break'
	exit 1
fi

torrents="$HOME/downloads/torrents"
mkdir -p "$torrents/session"
touch "$torrents/.torrent.rc"

set -x
exec docker run -it --rm \
	--name rtorrent \
	-v "$torrents:/torrents" \
	tianon/rtorrent "$@"
