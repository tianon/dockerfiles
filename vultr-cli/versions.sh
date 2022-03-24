#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

json="$(git-tags 'https://github.com/vultr/vultr-cli.git')"

version="$(jq <<<"$json" -r '.version')"
checksums="$(wget -qO- "https://github.com/vultr/vultr-cli/releases/download/v${version}/vultr-cli_v${version}_checksums.txt")"
# TODO parse this file's contents in "jq" so it's easier to add more entries/translations?
sha256amd64="$(
	grep <<<"$checksums" -E '_linux_64-bit[.]tar[.]gz$' \
		| cut -d' ' -f1
)"
[ -n "$sha256amd64" ]
sha256arm64="$(
	grep <<<"$checksums" -E '_linux_arm64-bit[.]tar[.]gz$' \
		| cut -d' ' -f1
)"
[ -n "$sha256arm64" ]
export sha256amd64 sha256arm64

jq <<<"$json" -S '
	del(.tag)
	| .arches = {
		"amd64": { sha256: env.sha256amd64 },
		"arm64v8": { sha256: env.sha256arm64 },
		# TODO urls?
	}
' > versions.json
