#!/bin/bash
set -e

set -x
mkdir -p "$HOME/plex-application-support"
rm -f "$HOME/plex-application-support/Plex Media Server"/*.pid
docker run -d \
	--name plex-media-server \
	--restart always \
	--net host \
	-v "$HOME/plex-application-support:/var/lib/plexmediaserver/Library/Application Support" \
	-v "$HOME:/host/$HOME:ro" \
	-e "HOME=/host/$HOME" \
	-w "/host/$HOME" \
	-u "$(id -u):$(id -g)" \
	tianon/plex-media-server "$@"
