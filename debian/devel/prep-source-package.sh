#!/bin/bash
set -e

usage() {
	echo "usage: $0 source-package repo-path"
	echo "   ie: $0 docker.io docker/docker.io.git"
	echo "   ie: $0 golang-dbus pkg-go/packages/golang-dbus.git"
	echo "   ie: $0 fake https://github.com/tianon/debian-fake.git"
}

pkg="$1"
repo="$2"

if [ -z "$pkg" -o -z "$repo" ]; then
	usage >&2
	exit 1
fi

if [[ "$repo" != *'://'* ]]; then
	repo="git://anonscm.debian.org/$repo"
fi

set -x
git clone "$repo" "/usr/src/$pkg"
cd "/usr/src/$pkg"
apt-get update && mk-build-deps -irt'apt-get -yV --no-install-recommends' debian/control
if [ -e debian/watch ]; then
	uscan --force-download --verbose --download-current-version
elif [ -x debian/helpers/generate-tarball.sh ]; then
	./debian/helpers/generate-tarball.sh ..
else
	exit 0
fi
origtargz --unpack
echo 'ready for dpkg-buildpackage -uc -us in' "/usr/src/$pkg"
