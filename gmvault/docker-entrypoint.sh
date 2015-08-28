#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- gmvault "$@"
fi

# if our command is a valid subcommand, let's invoke it
# (this allows for "docker run gmvault sync", etc)
if gmvault "$1" -h > /dev/null 2>&1; then
	set -- gmvault "$@"
fi

exec "$@"
