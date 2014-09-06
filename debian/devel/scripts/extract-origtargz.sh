#!/bin/bash
set -e

# similar to "origtargz --unpack", but supports multiple upstream tarballs
usage() {
	echo
	echo "usage: $0 [options]"
	echo "   ie: $0 --tarballs /my/tarballs"
	echo "       $0 --dest /usr/src/my-cool-package"
	echo
	echo 'options:'
	echo '  -h, -?, --help        show usage'
	echo '  -t, --tarballs <dir>  where to look for tarballs (multiple)'
	echo '      (defaults to ".." and "../tarballs" if not specified)'
	echo '  -d, --debian <dir>    where to look for debian/'
	echo '      (defaults to "<dest>/debian")'
	echo '  -e, --dest <dir>      where to look for the current source'
	echo '      (defaults to ".")'
	echo
}

if ! options="$(getopt -n "$0" -o 'h?t:d:e:' --long 'help,tarballs:,debian:,dest:' -- "$@")"; then
	usage >&2
	exit 1
fi
eval set -- "$options"

tarballs=()
dest='.'
debian=

while true; do
	flag="$1"
	shift
	case "$flag" in
		-h|'-?'|--help)
			usage
			exit 0
			;;
		-d|--debian)
			debian="$1"
			shift
			;;
		-e|--dest)
			dest="$1"
			shift
			;;
		-t|--tarballs)
			tarballs+=( "$1" )
			shift
			;;
		--)
			break
			;;
	esac
done

if [ "${#tarballs[@]}" -eq 0 ]; then
	tarballs=( .. ../tarballs )
fi

if [ ! -d "$dest" ]; then
	echo >&2 "error: '$dest' does not exist or is not a directory"
	exit 1
fi

dest="$(readlink -f "$dest")"
if [ -z "$debian" ]; then
	debian="$dest/debian"
fi
if [ ! -d "$debian" ]; then
	echo >&2 "error: '$debian' does not exist or is not a directory"
	exit 1
fi
debian="$(readlink -f "$debian")"
changelog="$debian/changelog"
if [ ! -f "$changelog" ]; then
	echo >&2 "error: "$changelog" does not exist or is not a file"
	exit 1
fi

pkg="$(dpkg-parsechangelog -l"$changelog" -SSource)"
ver="$(dpkg-parsechangelog -l"$changelog" -SVersion)"
origVer="${ver%-*}" # strip everything from the last dash
origVer="$(echo "$origVer" | sed -r 's/^[0-9]+://')" # strip epoch
origTarballPrefix="${pkg}_${origVer}.orig"

origTarball=
tarballDir=
for dir in "${tarballs[@]}"; do
	for f in "$dir/$origTarballPrefix".tar.*; do
		if [ -f "$f" ]; then
			origTarball="$f"
			tarballDir="$dir"
			break 2
		fi
	done
done

if [ -z "$origTarball" ]; then
	echo >&2 "error: no '$origTarballPrefix.tar.*' in any of:" "${tarballs[@]}"
	exit 1
fi

origTarball="$(readlink -f "$origTarball")"
tarballDir="$(readlink -f "$tarballDir")"

declare -A multiTarballs
multiTarballs=()
for f in "$tarballDir/$origTarballPrefix"-*.tar.*; do
	if [ -f "$f" ]; then
		component="${f#$tarballDir/$origTarballPrefix-}"
		component="${component%%.tar.*}"
		multiTarballs[$component]="$f"
	fi
done

extractTarball() {
	tarball="$1"
	shift
	destDir="$1"
	shift
	excludes=( "$@" ) # for preventing debian/ from being clobbered
	
	rsyncArgs=()
	for exclude in "${excludes[@]}"; do
		if [ "${exclude#$destDir/}" != "$exclude" ]; then
			rsyncArgs+=( --exclude="${exclude#$destDir/}" )
		fi
	done
	
	tmpDir="$(mktemp -d)"
	
	echo -n "extracting '$tarball' ... "
	tar -xf "$tarball" -C "$tmpDir"
	echo 'done'
	
	files=( "$tmpDir"/* )
	if [ "${#files[@]}" -eq 0 ]; then
		rm -rf "$tmpDir"
		return
	fi
	
	srcDir="${files[0]}"
	if [ "${#files[@]}" -gt 1 ]; then
		echo >&2 "warning: '$tarball' contained more than just a single directory"
		echo >&2 "  ignoring all except $srcDir"
	fi
	
	echo -n "filling '$destDir' ... "
	rsync -a "${rsyncArgs[@]}" "$srcDir"/ "$destDir"/
	echo 'done'
	
	rm -rf "$tmpDir"
}

echo -n "cleaning out '$dest' (excluding '.git', '.svn', and '$debian') ... "
find "$dest" -mindepth 1 \( -name '.git' -o -name '.svn' -o -path "$debian" \) -prune -o -exec rm -rf '{}' +
echo 'done'

extractTarball "$origTarball" "$dest" "$debian"

for component in "${!multiTarballs[@]}"; do
	compTarball="${multiTarballs[$component]}"
	extractTarball "$compTarball" "$dest/$component" "$debian"
done
