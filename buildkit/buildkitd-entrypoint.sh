#!/usr/bin/env bash
set -Eeuo pipefail

if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	set -- buildkitd "$@"
fi

if [ "$1" = 'buildkitd' ]; then
	set -- dind "$@"
fi

exec "$@"
