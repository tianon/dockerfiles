#!/bin/bash
set -eo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

current="$(
	wget -qO- 'http://archive.ubuntu.com/ubuntu/dists/xenial/universe/binary-amd64/Packages.xz' \
		| xz -d \
		| awk -F ': ' '
			$1 == "Package" { pkg = $2 }
			$1 == "Version" && pkg == "snapcraft" { print $2 }
		'
)"

set -x
sed -ri 's/^(ENV SNAPCRAFT_VERSION) .*/\1 '"$current"'/' Dockerfile
