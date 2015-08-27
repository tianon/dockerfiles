#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
./update.sh
git add .
git commit -m 'Run docker/update.sh'
git push

./build.sh
./push.sh
