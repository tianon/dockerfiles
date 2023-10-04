#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

# "deb https://downloads.plex.tv/repo/deb public main" ("/etc/apt/sources.list.d/plexmediaserver.list")
# signed by https://downloads.plex.tv/plex-keys/PlexSign.key

#version="$(curl -fsSL 'https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&channel=16&distro=ubuntu' | sed -n 's/.*Release.*version="\([^"]*\)".*/\1/p')"

json="$(wget -qO- 'https://plex.tv/api/downloads/1.json' | jq -c '.computer.Linux')"

version="$(jq <<<"$json" -r '.version')"

echo "plex-media-server: $version"

json="$(jq <<<"$json" -c -L../../.libs '
	include "lib"
	;
	{
		version: .version,
		arches: (
			.releases
			| map(
				select(.distro == "debian")
				| {
					# wget -qO- "https://plex.tv/api/downloads/1.json" | jq "[ .computer.Linux.releases[].build ] | unique"
					"linux-aarch64": "arm64v8",
					"linux-armv7neon": "arm32v7",
					"linux-x86": "i386",
					"linux-x86_64": "amd64",
				}[.build] as $arch
				| select($arch)
				| {
					($arch): {
						url: .url,
						sha1: .checksum,
						dpkgArch: ($arch | deb_arch),
					},
				}
			)
			| add
		),
	}
')"

jq <<<"$json" '.' > versions.json
