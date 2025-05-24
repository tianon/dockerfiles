#!/usr/bin/env bash
set -Eeuo pipefail

if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	set -- readsb "$@"
fi

if [ "$1" = 'readsb' ]; then
	if [ -n "${READSB_UUID:-}" ]; then
		echo "$READSB_UUID" > /tmp/readsb-uuid
		set -- "$@" --uuid-file /tmp/readsb-uuid
	fi
fi

exec "$@"
