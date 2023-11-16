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
			--entrypoint dind \
			"${cmd[@]}"
			containerd
		)
		;;
esac

cname="containerd-container-$RANDOM-$RANDOM"
cid="$(
	docker run -d -it \
		--privileged \
		--name "$cname" \
		--env DOCKER_TLS_CERTDIR= \
		"${cmd[@]}"
)"
trap "docker rm -vf $cid > /dev/null" EXIT

ctr_() {
	docker exec -i "$cname" ctr "$@"
}

# poor man's retry.sh
tries=30
while (( --tries > 0 )) && ! ctr_ version &> /dev/null; do
	if ! running="$(docker inspect -f '{{ .State.Running }}' "$cid" 2>/dev/null)" || [ "$running" != 'true' ]; then
		echo >&2 "$image stopped unexpectedly!"
		( set -x && docker logs "$cid" ) >&2 || true
		false
	fi
	echo >&2 -n .
	sleep 1
done
ctr_ version > /dev/null

testImage='docker.io/tianon/true:yoloci'

[ "$(ctr_ image ls -q | wc -l)" = '0' ]
ctr_ content fetch "$testImage"
[ "$(ctr_ image ls -q | wc -l)" = '1' ]

[ "$(ctr_ container ls -q | wc -l)" = '0' ]

ctr_ run --rm "$testImage" test
ctr_ run --rm "$testImage" test
ctr_ run --rm "$testImage" test

[ "$(ctr_ container ls -q | wc -l)" = '0' ]
