#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

url="$(
	curl -fsSL 'https://www.makemkv.com/forum/viewtopic.php?f=3&t=224' \
		| grep -oE 'href="https://[^"]+/makemkv-bin-[^"]+.tar.gz"' \
		| cut -d'"' -f2
)"
version="$(basename "$url" | sed -r 's!^makemkv-bin-|.tar.gz$!!g')"

set -x
sed -ri 's!^(ENV MAKEMKV_VERSION) .*!\1 '"$version"'!' Dockerfile
