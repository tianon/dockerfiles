#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

# https://www.mozilla.org/en-US/firefox/all/#product-desktop-release
url="$(
	curl -fsS --head 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US' \
		| gawk -F ':[[:space:]]+' '
			tolower($1) == "location" {
				print $2
				exit
			}
		'
)"
version="$(basename "$url")"
version="${version#firefox-}"
version="${version%%.tar.*}"
export version

echo >&2 "firefox: $version"

jq -nS '{ version: env.version }' > versions.json
