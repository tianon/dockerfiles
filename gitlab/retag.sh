#!/usr/bin/env bash
set -Eeuo pipefail

src='gitlab/gitlab-ce'
dst='tianon/gitlab'

# before running this script, I start (unprivileged) containerd in a separate container:
#   docker run -dit --name containerd --restart always --user nobody --security-opt no-new-privileges tianon/containerd
# https://hub.docker.com/r/tianon/containerd
# (containerd makes mirroring existing images verbatim orders of magnitude simpler :D)

ctr() {
	tty=
	if [ -t 0 ] && [ -t 1 ]; then
		tty='--tty'
	fi
	docker exec $tty --interactive containerd ctr "$@"
}

# get Docker Hub credentials from ~/.docker/config.json O:)
auth="$(jq -r '.auths."https://index.docker.io/v1/".auth' ~/.docker/config.json | base64 -d)"
[ -n "$auth" ]

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
	ctrSrc="docker.io/$src:$srcTag"
	ctrDst="docker.io/$dst:$dstTag"
	echo
	echo "+ docker pull $src:$srcTag"
	ctr content fetch --metadata-only "$ctrSrc"
	echo
	echo "+ docker tag $src:$srcTag $dst:$dstTag"
	if [ "${1:-}" = '--push' ]; then
		echo
		echo "+ docker push $dst:$dstTag"
		ctr images push --user "$auth" "$ctrDst" "$ctrSrc"
	fi
done
