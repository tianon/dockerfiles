#!/usr/bin/env bash
set -Eeuo pipefail

script="$1"
[ -x "$script" ]
shift

case "$script" in
	/* | */*) ;;
	*) script="./$script" ;;
esac

if [ "$#" -eq 0 ]; then
	dirs="$(find -type f -name versions.json -exec bash -Eeuo pipefail -c 'for d; do dir="$(dirname "${d#./}")"; printf " %q" "$dir"; done' -- '{}' +)"
	eval "set -- $dirs"
fi
if [ "$#" -eq 0 ]; then
	echo >&2 "error: failed to find any 'versions.json' files!"
	exit 1
fi

nproc="$(nproc)"
xargs <<<"$*" -rtn1 -P "$nproc" "$script"
# TODO "$*" here irks me -- I would love to do something cleaner (although it's mostly fine for the use case of this script)
