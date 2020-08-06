#!/bin/sh
set -eu

if [ "${1:0:1}" = '-' ] || bw "$1" --help > /dev/null 2>&1; then
	set -- bw "$@"
fi

exec "$@"
