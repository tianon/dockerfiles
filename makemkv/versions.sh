#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

url="$(
	curl -fsSL 'https://forum.makemkv.com/forum/viewtopic.php?f=3&t=224' \
		| grep -oE 'href="https?://[^"]+/makemkv-bin-[^"]+.tar.gz"' \
		| cut -d'"' -f2
)"
version="$(basename "$url" | sed -r 's!^makemkv-bin-|.tar.gz$!!g')"
export version

echo >&2 "makemkv: $version"

jq -nS '{ version: env.version }' > versions.json
