#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

version="$(
	curl -fsS --head 'https://zoom.us/client/latest/zoom_amd64.deb' \
		| gawk -F ':[[:space:]]+' '
			tolower($1) == "location" {
				if (match($2, /[/]([^/]+)[/]zoom_[^.]+[.]deb/, m)) {
					print m[1]
					exit
				}
			}
		'
)"

echo "zoom: $version"

sed -ri -e 's!^(ENV ZOOM_VERSION) .*!\1 '"$version"'!' Dockerfile
