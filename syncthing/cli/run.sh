#!/bin/bash
set -e

if [ "$HOME" = '/home/user' ]; then
	echo >&2 'uh oh, HOME=/home/user'
	exit 1
fi

mkdir -p "$HOME/.config/syncthing"

dashT=
if [ -t 1 ]; then
	dashT='-t'
fi

#set -x
#	-v /etc:/host/etc \
exec docker run -i $dashT --rm \
	-u "$(id -u):$(id -g)" \
	-v "$HOME:$HOME" \
	-v "$HOME/.config/syncthing:/home/user/.config/syncthing" \
	--net host \
	-e STENDPOINT='http://127.0.0.1:8080' \
	tianon/syncthing-cli syncthing-cli "$@"
