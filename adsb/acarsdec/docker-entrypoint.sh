#!/usr/bin/env bash
set -Eeuo pipefail

if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	set -- acarsdec "$@"
fi

exec "$@"
