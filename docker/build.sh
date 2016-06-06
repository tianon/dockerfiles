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
	docker build -t "$image:$version" --pull "$version"
	docker build -t "$image:$version-dind" "$version/dind"
	docker build -t "$image:$version-git" "$version/git"
	if [ "$version" = 'master' ]; then
		docker tag "$image:$version" "$image:latest"
		docker tag "$image:$version-dind" "$image:dind"
		docker tag "$image:$version-git" "$image:git"
	fi
done
