#!/bin/bash
set -eo pipefail

dir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

image="$1"
cmd=( "$image" )

case "$image" in
	*docker*containerd*) ;;

	*docker* | *moby*)
		cmd=(
			--volume /var/lib/containerd
			--tmpfs /run
			"${cmd[@]}"
			dind containerd
		)
		;;
esac

cname="containerd-container-$RANDOM-$RANDOM"
cid="$(
	docker run -d -it \
		--privileged \
		--name "$cname" \
		"${cmd[@]}"
)"
trap "docker rm -vf $cid > /dev/null" EXIT

ctr_() {
	docker exec -i "$cname" ctr "$@"
}

# poor man's retry.sh
tries=30
while (( --tries > 0 )) && ! ctr_ version &> /dev/null; do
	sleep 1
done
ctr_ version > /dev/null

[ "$(ctr_ image ls -q | wc -l)" = '0' ]
ctr_ content fetch docker.io/tianon/true:yoloci
[ "$(ctr_ image ls -q | wc -l)" = '1' ]

[ "$(ctr_ container ls -q | wc -l)" = '0' ]

ctr_ run --rm docker.io/tianon/true:yoloci test
ctr_ run --rm docker.io/tianon/true:yoloci test
ctr_ run --rm docker.io/tianon/true:yoloci test

[ "$(ctr_ container ls -q | wc -l)" = '0' ]
