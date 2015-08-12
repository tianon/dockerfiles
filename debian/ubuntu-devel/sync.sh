#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
rsync -avP ../devel/ ./
awk '
	$1 == "FROM" { $2 = "ubuntu-debootstrap:devel" }
	/incoming.debian.org/ { next }
	{ print }
' ../devel/Dockerfile > Dockerfile
