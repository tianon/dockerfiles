#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
./update.sh
git add .
if git commit -m 'Run docker/update.sh'; then
	git push
fi

./build.sh
./push.sh
