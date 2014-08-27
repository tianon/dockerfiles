#!/bin/bash
set -e

usage() {
	echo "usage: $0 source-package repo-path"
	echo "   ie: $0 docker.io docker/docker.io.git"
	echo "   ie: $0 golang-dbus pkg-go/packages/golang-dbus.git"
	echo "   ie: $0 fake https://github.com/tianon/debian-fake.git"
	echo "   ie: $0 python-astor svn://svn.debian.org/svn/python-modules/packages/python-astor/trunk"
}

pkg="$1"
repo="$2"

if [ -z "$pkg" -o -z "$repo" ]; then
	usage >&2
	exit 1
fi

scriptDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
"$scriptDir/prep-source-package.sh" "$pkg" "$repo"
cd "/usr/src/$pkg"
dpkg-buildpackage -uc -us
debi || apt-get install -f -y
