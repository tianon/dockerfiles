#!/bin/bash
set -ex

if [[ "$1" == inbox-* ]]; then
	if ! verify-db &> /dev/null; then
		create-db
	fi
fi

exec "$@"
