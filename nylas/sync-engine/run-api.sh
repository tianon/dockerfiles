#!/bin/bash
set -e

docker run -dit \
	--restart always \
	--name nylas-sync-api \
	--link nylas-sync-mysql:mysql \
	--expose 5555 \
	tianon/nylas-sync-engine \
	inbox-api
