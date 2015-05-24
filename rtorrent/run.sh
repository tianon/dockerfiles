#!/bin/bash
set -e

torrents="$HOME/downloads/torrents"
mkdir -p "$torrents/session"
touch "$torrents/.torrent.rc"

set -x
exec docker run -it --rm \
	--name rtorrent \
	-v "$torrents:/torrents" \
	-e TERM \
	-u "$(id -u):$(id -g)" \
	tianon/rtorrent "$@"
