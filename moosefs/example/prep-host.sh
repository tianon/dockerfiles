#!/usr/bin/env bash
set -Eeuo pipefail

mkdir -vp \
	/mnt/mfs/chunks/.skel/chunks \
	/mnt/mfs/chunks/.skel/var-lib-mfs \
	/mnt/mfs/fs \
	/mnt/mfs/master/var-lib-mfs \
	/mnt/mfs/meta

echo -n > /mnt/mfs/chunks/.skel/mfshdd.cfg
echo -n 'MFSM NEW' > /mnt/mfs/master/var-lib-mfs/metadata.mfs.empty

find /mnt/mfs -xdev -exec chown --changes -P 9400:9400 '{}' +
