#!/bin/bash
set -e

docker run -dit \
	--restart always \
	--name nylas-sync-redis \
	redis
