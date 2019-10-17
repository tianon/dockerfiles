#!/usr/bin/env bash
set -Eeuo pipefail

if ! docker container inspect mfs-pause &> /dev/null; then
	# TODO switch to a multi-arch image
	docker run -d --network mfs --name mfs-pause --restart always tianon/sleeping-beauty
fi

for d in /mnt/mfs/chunks/*/; do
	d="${d%/}"
	base="$(basename "$d")"
	d="$(cd "$d" && pwd -P)"

	if [ ! -s "$d/mfshdd.cfg" ] && [ -d "$d/chunks" ]; then
		echo "$d/chunks" > "$d/mfshdd.cfg"
		chown 9400:9400 "$d/mfshdd.cfg"
	fi

	if [ -s "$d/mfshdd.cfg" ] && [ -d "$d/var-lib-mfs" ]; then
		name="mfs-chunkserver-$base"
		if docker container inspect "$name" &> /dev/null; then
			docker container start "$name"
		else
			# TODO handle ports more safely
			# TODO handle additional configuration
			docker run -d \
				--restart always \
				--name "$name" \
				--network container:mfs-pause \
				--mount "type=bind,source=$d,destination=$d,bind-propagation=rslave" \
				-e MFSCHUNKSERVER_DATA_PATH="$d/var-lib-mfs" \
				-e MFSCHUNKSERVER_HDD_CONF_FILENAME="$d/mfshdd.cfg" \
				-e MFSCHUNKSERVER_CSSERV_LISTEN_PORT="$RANDOM" \
				tianon/moosefs:3 \
				mfschunkserver -fun
		fi
	else
		echo >&2 "warning: '$d' exists, but is missing either 'mfshdd.cfg' or 'var-lib-mfs' so does not appear to be prepped properly"
		continue
	fi
done
