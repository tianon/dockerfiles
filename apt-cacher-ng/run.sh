#!/bin/bash
set -e

exec docker run -d \
	--name apt-cacher-ng \
	--restart always \
	--dns 8.8.8.8 --dns 8.8.4.4 \
	--tmpfs /var/cache/apt-cacher-ng \
	tianon/apt-cacher-ng "$@"
