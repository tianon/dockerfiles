#!/bin/bash
set -e

docker run -dit \
	--restart always \
	--name nylas-sync-engine \
	--link nylas-sync-mysql:mysql \
	--link nylas-sync-redis:redis \
	--expose 16384 \
	tianon/nylas-sync-engine \
	inbox-start
