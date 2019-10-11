#!/usr/bin/env bash
set -Eeuo pipefail

args=(
	--interactive
)
if [ -t 0 ] && [ -t 1 ]; then
	args+=( --tty )
fi
if [ "${PWD##/mnt/mfs/fs}" != "$PWD" ]; then
	args+=( --workdir "$PWD" )
fi

exec docker exec "${args[@]}" mfs-mount-fs mfscli "$@"
