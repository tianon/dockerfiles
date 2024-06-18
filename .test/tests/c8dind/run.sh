#!/bin/bash
set -eo pipefail

dir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

image="$1"

cname="containerd-container-$RANDOM-$RANDOM"
trap 'set +Eeo pipefail; docker rm -vf "$cname" > /dev/null; docker volume rm -f "$cname-run" &> /dev/null' EXIT

cmd=(
	--detach --interactive --tty
	--privileged
	--name "$cname"
	--volume "$cname-run:/run"
	--env DOCKER_TLS_CERTDIR=
	"$image"
)

case "$image" in
	*docker*containerd*) ;;

	*docker* | *moby*)
		cmd=(
			--volume /var/lib/containerd
			--entrypoint dind \
			"${cmd[@]}"
			containerd
		)
		;;
esac

cid="$(docker run "${cmd[@]}")"

# this gets redefined below, but during init we have to use a separate container because "docker exec" creates a new process and creates a race inside the dind script (where it's trying to move pids between cgroups, but the new pid breaks it)
ctr_() {
	docker run --rm --volume "$cname-run:/run" --entrypoint ctr "$image" "$@"
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

# now that init is done, "docker exec" is safe again (and necessary for "ctr run" to work because it requires being in the same mount namespace 😭)
ctr_() {
	docker exec -i "$cname" ctr "$@"
}
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
