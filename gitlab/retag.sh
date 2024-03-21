#!/usr/bin/env bash
set -Eeuo pipefail

src='gitlab/gitlab-ce'
dst='tianon/gitlab'

tags="$(
	crane ls "$src" \
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
		8 | 9 | 10 | 11 | 12) continue ;;
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
	ctrSrc="$src:$srcTag"
	ctrDst="$dst:$dstTag"
	echo
	(
		set -x
		crane cp "$ctrSrc" "$ctrDst"
	)
done
