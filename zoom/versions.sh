#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

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
export version

echo >&2 "zoom: $version"

jq -nS '{ version: env.version }' > versions.json
