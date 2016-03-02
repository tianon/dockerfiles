#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

develSuite="$(curl -fsSL 'http://archive.ubuntu.com/ubuntu/dists/devel/Release' | awk -F ': ' '$1 == "Suite" { print $2 }')"

set -x
rsync -avP ../devel/ ./
awk '
	$1 == "FROM" { $2 = "ubuntu:'"$develSuite"'" }
	/incoming.debian.org/ { next }
	{ print }
' ../devel/Dockerfile > Dockerfile
