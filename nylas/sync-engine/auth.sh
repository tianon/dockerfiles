#!/bin/bash
set -e

docker run -it --rm \
	--link nylas-sync-mysql:mysql \
	tianon/nylas-sync-engine \
	inbox-auth "$@"
