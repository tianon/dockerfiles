#!/usr/bin/env bash
set -Eeuo pipefail

if [ "$#" -eq 0 ]; then
	dirs="$(find -type f -name versions.json -exec bash -Eeuo pipefail -c 'for d; do dir="$(dirname "${d#./}")"; printf " %q" "$dir"; done' -- '{}' +)"
	eval "set -- $dirs"
fi
if [ "$#" -eq 0 ]; then
	echo >&2 "error: failed to find any 'versions.json' files!"
	exit 1
fi

for dir; do
	export dir

	script="$dir"
	while [ ! -x "$script/versions.sh" ]; do
		if [ "$script" = '.' ]; then
			echo >&2 "error: failed to find script for '$dir'!"
			exit 1
		fi
		script="$(dirname "$script")"
	done

	text="$dir"
	if [ "$dir" != "$script" ]; then
		text+=" ($script)"
	fi
	echo "processing $text ..."

	script="$(readlink -ve "$script/versions.sh")"
	(
		cd "$dir"
		source "$script"
	)
done
