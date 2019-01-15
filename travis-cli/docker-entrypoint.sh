#!/bin/sh
set -eu

# if we have no commands or "$1" looks like a flag or appears to be a "travis" subcommand ("whoami", etc), inject "travis"
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ] || travis "$1" --help > /dev/null 2>&1; then
	set -- travis "$@"
fi

exec "$@"
