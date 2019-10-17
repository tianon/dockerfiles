#!/usr/bin/env bash
set -Eeuo pipefail

for d in /mnt/mfs/chunks/*/; do
	d="${d%/}"
	if [ -L "$d" ] || mountpoint --quiet "$d"; then
		# if it's a symlink or already a mountpoint, ignore it
		continue
	fi
	uuid="$(basename "$d")"
	if [ ! -e "/dev/disk/by-uuid/$uuid" ]; then
		echo >&2 "warning: partition '$uuid' does not appear to exist! ($d)"
		continue
	fi
	mount -o noatime "/dev/disk/by-uuid/$uuid" "$d"
done
