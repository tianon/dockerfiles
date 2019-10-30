#!/usr/bin/env bash
set -Eeuo pipefail

src='gitlab/gitlab-ce'
dst='tianon/gitlab'

tags="$(
	# https://github.com/tianon/docker-bin/blob/master/docker-hub-list-tags.sh
	docker-hub-list-tags.sh "$src" \
		| grep -E '^[0-9]+[.][0-9]+[.][0-9]+(-ce([.][0-9]+)?)?$' \
		| sort -rV
)"

declare -A latest=()

for tag in $tags; do
	majorMinor="${tag%%-*}" # "x.y.z-ce.0" -> "x.y.z"
	majorMinor="${majorMinor%.*}" # "x.y.z" -> "x.y"
	major="${majorMinor%%.*}" # "x.y" -> "x"

	# ignore older versions
	case "$major" in
		8 | 9 | 10 | 11) continue ;;
	esac

	if [ -z "${latest[latest]:-}" ]; then
		latest[latest]="$tag"
	fi
	if [ -z "${latest[$majorMinor]:-}" ]; then
		latest[$majorMinor]="$tag"
	fi
	if [ -z "${latest[$major]:-}" ]; then
		latest[$major]="$tag"
	fi
done

for dstTag in "${!latest[@]}"; do
	srcTag="${latest[$dstTag]}"
	( set -x; docker pull "$src:$srcTag" )
	( set -x; docker tag "$src:$srcTag" "$dst:$dstTag" )
	if [ "${1:-}" = '--push' ]; then
		( set -x; docker push "$dst:$dstTag" )
	fi
done
