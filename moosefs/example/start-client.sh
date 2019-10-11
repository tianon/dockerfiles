#!/usr/bin/env bash
set -Eeuo pipefail

[ -d /mnt/mfs/fs ]
[ -d /mnt/mfs/meta ]

if ! docker container inspect mfs-pause &> /dev/null; then
	# TODO switch to a multi-arch image
	docker run -d --network mfs --name mfs-pause --restart always tianon/sleeping-beauty
fi

if ! docker container inspect mfs-mount-fs &> /dev/null; then
	docker run -d \
		--restart always \
		--name mfs-mount-fs \
		--network container:mfs-pause \
		--cap-add SYS_ADMIN \
		--device /dev/fuse \
		--security-opt apparmor=unconfined \
		--mount type=bind,source=/mnt/mfs/fs,destination=/mnt/mfs/fs,bind-propagation=rshared \
		tianon/moosefs:3 \
		mfsmount -f \
			-o large_read \
			-o auto_unmount \
			-o mfssugidclearmode=ALWAYS \
			/mnt/mfs/fs
fi

if ! docker container inspect mfs-mount-meta &> /dev/null; then
	docker run -d \
		--restart always \
		--name mfs-mount-meta \
		--network container:mfs-pause \
		--cap-add SYS_ADMIN \
		--device /dev/fuse \
		--security-opt apparmor=unconfined \
		--mount type=bind,source=/mnt/mfs/meta,destination=/mnt/mfs/meta,bind-propagation=rshared \
		tianon/moosefs:3 \
		mfsmount -f \
			-o large_read \
			-o auto_unmount \
			-o mfssugidclearmode=ALWAYS \
			-o mfsmeta \
			-o mfsflattrash \
			/mnt/mfs/meta
fi
