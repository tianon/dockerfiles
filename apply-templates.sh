#!/usr/bin/env bash
set -Eeuo pipefail

jqt="$(dirname "$BASH_SOURCE")"
jqt="$jqt/.jq-template.awk"
if [ -n "${BASHBREW_SCRIPTS:-}" ]; then
	jqt="$BASHBREW_SCRIPTS/jq-template.awk"
elif [ "$BASH_SOURCE" -nt "$jqt" ]; then
	# https://github.com/docker-library/bashbrew/blob/master/scripts/jq-template.awk
	jqtNew="$jqt.new.$$" # using a (unique) ".new" file so this is safe to run concurrently
	wget -qO "$jqtNew" 'https://github.com/docker-library/bashbrew/raw/1da7341a79651d28fbcc3d14b9176593c4231942/scripts/jq-template.awk'
	mv -f "$jqtNew" "$jqt"
fi
jqt="$(readlink -ve "$jqt")"

if [ "$#" -eq 0 ]; then
	dirs="$(find -type f -name versions.json -exec bash -Eeuo pipefail -c 'for d; do dir="$(dirname "${d#./}")"; printf " %q" "$dir"; done' -- '{}' +)"
	eval "set -- $dirs"
fi
if [ "$#" -eq 0 ]; then
	echo >&2 "error: failed to find any 'versions.json' files!"
	exit 1
fi

generated_warning() {
	cat <<-EOH
		#
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
		#

	EOH
}

for dir; do
	export dir

	template="$dir"
	while [ ! -s "$template/Dockerfile.template" ]; do
		if [ "$template" = '.' ]; then
			echo >&2 "error: failed to find template for '$dir'!"
			exit 1
		fi
		template="$(dirname "$template")"
	done

	variants="$(jq -r '.variants // [""] | map(@sh) | join(" ")' "$dir/versions.json")"
	eval "variants=( $variants )"

	text="$dir"
	if [ "$dir" != "$template" ]; then
		text+=" ($template)"
	fi
	template="$template/Dockerfile.template"

	for variant in "${variants[@]}"; do
		export variant

		echo "processing $text${variant:+" variant '$variant'"} ..."

		(
			cd "$dir"
			generated_warning
			gawk -f "$jqt"
		) < "$template" > "$dir/Dockerfile${variant:+".$variant"}"
	done
done
