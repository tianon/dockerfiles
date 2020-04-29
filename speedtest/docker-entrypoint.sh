#!/bin/sh
set -eu

if [ "${1:0:1}" = '-' ]; then
	set -- speedtest "$@"
fi

exec "$@"
