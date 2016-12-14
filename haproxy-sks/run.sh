#!/bin/bash
set -e

exec docker run -d \
	--name haproxy-sks \
	--restart always \
	--dns 8.8.8.8 --dns 8.8.4.4 \
	tianon/haproxy-sks "$@"
