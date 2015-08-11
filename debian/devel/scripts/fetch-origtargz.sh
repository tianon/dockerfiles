#!/bin/bash
set -e

pkg="$(dpkg-parsechangelog -SSource)"
ver="$(dpkg-parsechangelog -SVersion)"
origVer="${ver%-*}" # strip everything from the last dash
if [ "$origVer" = "$ver" ]; then
	# native package!  no orig.tar exists
	echo >&2 "$pkg is native! ($ver)"
	exit
fi
origVer="$(echo "$origVer" | sed -r 's/^[0-9]+://')" # strip epoch
origTarballPrefix="${pkg}_${origVer}.orig"

source ~/.devscripts
tarballDir="${USCAN_DESTDIR:-..}"

check_it() {
	f=( "$tarballDir/$origTarballPrefix".tar.* )
	if [ "${#f[@]}" -gt 0 ]; then
		echo "${f[0]}"
		exit
	fi
}
check_it

IFS=$'\n'
pt=( $(pristine-tar list | grep "^$origTarballPrefix\.tar\.") )
unset IFS

if [ "${#pt[@]}" -gt 0 ]; then
	pristine-tar checkout "$tarballDir/${pt[0]}"
	check_it
fi

IFS=$'\n'
aptVersions=( $(apt-cache showsrc "$pkg" | awk -F ': ' '$1 == "Version" { print $2 }') )
unset IFS

for aptVersion in "${aptVersions[@]}"; do
	aptOrigVer="${aptVersion%-*}" # strip everything from the last dash
	aptOrigVer="$(echo "$aptOrigVer" | sed -r 's/^[0-9]+://')" # strip epoch
	if [ "$origVer" = "$aptOrigVer" ]; then
		( cd "$tarballDir" && apt-get source --only-source --download-only --tar-only "$pkg=$aptVersion" )
		check_it
	fi
done

# if we have d/watch, let's try uscan, since it's superfast and rules
if [ -e debian/watch ]; then
	uscan --download-current-version --rename --destdir "$tarballDir"
	check_it
fi

# failing uscan, let's check to see if there's a "generate-tarball" helper
if [ -x debian/helpers/generate-tarball.sh ]; then
	./debian/helpers/generate-tarball.sh "$tarballDir"
	check_it
fi

echo >&2 "cannot find $origTarballPrefix.tar.*"
exit 1
