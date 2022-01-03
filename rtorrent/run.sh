#!/bin/bash
set -e

torrents="$HOME/downloads/torrents"
mkdir -p "$torrents/session"
touch "$torrents/.rtorrent.rc"

set -x
exec docker run -it --rm \
	--name rtorrent \
	--hostname rtorrent \
	--mount "type=bind,src=$torrents,dst=/torrents" \
	--env TERM \
	--user "$(id -u):$(id -g)" \
	--read-only \
	tianon/rtorrent "$@"
