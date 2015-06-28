#!/bin/bash
set -e

# TODO replace --privileged with other stuff somehow
docker run -it --rm \
	-v "$PWD:/host/$PWD" \
	-w "/host/$PWD" \
	--device /dev/kvm \
	--privileged \
	tianon/vmdebootstrap \
	vmdebootstrap "$@"
