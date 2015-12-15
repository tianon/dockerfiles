#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
./update.sh
if git commit -m 'Run docker/update.sh' .; then
	git push
fi

#docker pull -a tianon/docker-master
./build.sh
./push.sh
