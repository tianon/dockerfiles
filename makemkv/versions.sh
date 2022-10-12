#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

{
	version="$(
		curl -fsSL 'https://makemkv.com/download/' \
			| grep -oE 'makemkv-sha-[0-9.]+.txt' \
			| sed -r 's!^makemkv-sha-|[.]txt$!!g'
	)"
	[ -n "$version" ]
} || {
	url="$(
		curl -fsSL 'https://forum.makemkv.com/forum/viewtopic.php?f=3&t=224' \
			| grep -oE 'href="https?://[^"]+/makemkv-bin-[^"]+.tar.gz"' \
			| cut -d'"' -f2
	)"
	[ -n "$url" ]
	version="$(basename "$url" | sed -r 's!^makemkv-bin-|[.]tar[.]gz$!!g')"
	[ -n "$version" ]
}
export version

echo >&2 "makemkv: $version"

jq -nS '{ version: env.version }' > versions.json
