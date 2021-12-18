#!/bin/bash
for file in `find . -name update.sh`; do
	pushd `dirname $file`
	./update.sh
	popd
done
