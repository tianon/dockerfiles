#!/bin/bash
set -e

mkdir -p "$HOME/temp/nylas-sync-mysql"
docker run -dit \
	--restart always \
	--name nylas-sync-mysql \
	-v "$HOME/temp/nylas-sync-mysql":/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=inboxapp \
	mysql:5.6
