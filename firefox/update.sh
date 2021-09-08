#!/usr/bin/env bash
set -Eeuo pipefail

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

echo "firefox: $version"
sed -ri -e 's!^(ENV FIREFOX_VERSION) .*!\1 '"$version"'!' Dockerfile
