#!/bin/bash
set -e

if [ "$HOME" = '/home/user' ]; then
	echo >&2 'uh oh, HOME=/home/user'
	exit 1
fi

if [ "$(id -u)" != 1000 -o "$(id -g)" != 1000 ]; then
	echo >&2 'uh, your UID and GID ought to be 1000, or things will likely break'
	exit 1
fi

mkdir -p "$HOME/.config/syncthing"

set -x
#	-v /etc:/host/etc \
docker run -d \
	--name syncthing \
	--restart always \
	-v "$HOME:$HOME" \
	-v "$HOME/.config/syncthing:/home/user/.config/syncthing" \
	--net host \
	tianon/syncthing "$@"
sleep 1
docker logs syncthing
