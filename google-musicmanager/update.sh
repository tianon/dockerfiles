#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

latest="$(
	curl -fsSL 'http://dl.google.com/linux/musicmanager/deb/dists/stable/main/binary-amd64/Packages' \
		| awk -F ': ' '
			$1 == "Package" { pkg = $2 }
			pkg == "google-musicmanager-beta" && $1 == "Version" { print $2; exit }
		'
)"
set -x
sed -ri 's/^(ENV GOOGLE_MUSICMANAGER_VERSION) .*/\1 '"$latest"'/' Dockerfile
