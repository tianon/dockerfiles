#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

for v in */; do
	v="${v%/}"
	sed "s/%VERSION%/$v/g" Dockerfile.template > "$v/Dockerfile"
	cp init-fake.conf "$v/"
done
