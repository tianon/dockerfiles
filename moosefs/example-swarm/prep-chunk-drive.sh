#!/usr/bin/env bash
set -Eeuo pipefail

# usage: $0 [device]
#    eg: $0 /dev/sdb

[ -d /mnt/mfs/chunks/.skel ]
[ "$#" = 1 ]
disk="$1"
[ -e "$disk" ]
[ ! -d "$disk" ]

parted "$disk" -- print
( set -x && sleep 10 ) # poor man's prompt (TODO make this better)
# perhaps detect that the drive has only a single partition and check whether that partition's UUID already exists in /mnt/mfs/chunks ?

parted --script "$disk" -- \
	mklabel gpt \
	mkpart primary ext4 '0%' '100%' \
	print
partprobe --summary "$disk"

part="$(lsblk --list --noheadings --paths --sort=NAME --output=NAME "$disk")"
part="$(tail -1 <<<"$part")"
[ "$part" != "$disk" ]

mkfs.ext4 -F -L moosefs-chunks -d /mnt/mfs/chunks/.skel "$part"

uuid="$(blkid --match-tag=UUID --output=value "$part")"

mkdir "/mnt/mfs/chunks/$uuid"

# this information (especially ID_SERIAL and ID_MODEL) is useful when drives die to be able to identify which drive is dead!
udevadm info --query=property --export "$part" > "/mnt/mfs/chunks/$uuid.udev"

chown 9400:9400 "/mnt/mfs/chunks/$uuid"*
