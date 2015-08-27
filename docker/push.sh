#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( */ )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

image='tianon/docker-master'
for version in "${versions[@]}"; do
	docker push "$image:$version"
	docker push "$image:$version-dind"
	docker push "$image:$version-git"
	if [ "$version" = 'master' ]; then
		docker push "$image:latest"
		docker push "$image:dind"
		docker push "$image:git"
	fi
done
