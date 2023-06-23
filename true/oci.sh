#!/usr/bin/env bash
set -Eeuo pipefail

folder="$1"; shift
[ ! -e "$folder" ] || [ -d "$folder" ]
bin="${1:-true-asm}"

rm -rf "$folder"
mkdir -p "$folder"

digest() {
	local sha256
	sha256="$(sha256sum "$@")" || return 1
	sha256="${sha256%% *}"
	printf 'sha256:%s' "$sha256"
}

tar \
	--create \
	--blocking-factor 1 \
	--owner=0 \
	--group=0 \
	--mtime=@0 \
	--numeric-owner \
	--mode=00555 \
	--transform 's/-.*$//' \
	-- "$bin" \
	| head --bytes=-1024 \
	> "$folder/rootfs.tar"
diffId="$(digest "$folder/rootfs.tar")"
export diffId

gzip --no-name --best < "$folder/rootfs.tar" > "$folder/rootfs.tar.gz"

time="$(git log -1 --format=format:%ct "$bin")"
created="$(date --date "@$time" --utc '+%Y-%m-%dT%H:%M:%SZ')"
export created

jq -n -S --tab '
	{
		os: "linux",
		architecture: "amd64",
		config: {
			Cmd: [ "/true" ],
		},
		created: env.created,
		history: [
			{
				created: env.created,
				created_by: "https://github.com/tianon/dockerfiles/tree/master/true",
			}
		],
		rootfs: {
			type: "layers",
			diff_ids: [ env.diffId ],
		},
	}
' > "$folder/config.json"

blob() {
	local file="$1"
	local digest
	digest="$(digest "$folder/$file")"
	local target="$folder/blobs/${digest//://}"
	local dir; dir="$(dirname "$target")"
	mkdir -p "$dir"
	ln -frsT "$folder/$file" "$target"
	printf '%s' "$digest"
}

config="$(blob config.json)"
rootfs="$(blob rootfs.tar.gz)"
export config rootfs
configSize="$(stat --format '%s' "$folder/config.json")"
rootfsSize="$(stat --format '%s' "$folder/rootfs.tar.gz")"
export configSize rootfsSize
configData="$(base64 --wrap=0 < "$folder/config.json")"
rootfsData="$(base64 --wrap=0 < "$folder/rootfs.tar.gz")"
export configData rootfsData

jq -n -S --tab '
	{
		schemaVersion: 2,
		mediaType: "application/vnd.oci.image.manifest.v1+json",
		config: {
			mediaType: "application/vnd.oci.image.config.v1+json",
			digest: env.config,
			size: (env.configSize | tonumber),
			data: env.configData,
		},
		layers: [
			{
				mediaType: "application/vnd.oci.image.layer.v1.tar+gzip",
				digest: env.rootfs,
				size: (env.rootfsSize | tonumber),
				data: env.rootfsData,
			}
		],
	}
' > "$folder/image-manifest.json"

manifest="$(blob image-manifest.json)"
manifestSize="$(stat --format '%s' "$folder/image-manifest.json")"
export manifest manifestSize

jq -n -S --tab '
	{
		schemaVersion: 2,
		mediaType: "application/vnd.oci.image.index.v1+json",
		manifests: [
			{
				mediaType: "application/vnd.oci.image.manifest.v1+json",
				digest: env.manifest,
				size: (env.manifestSize | tonumber),
			}
		]
	}
' | tee "$folder/index.json"
