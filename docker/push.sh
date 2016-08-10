#!/bin/bash
set -e

repo='tianon/docker-master'

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( */ )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do
	( set -x && docker push "$repo:$version" )
	( set -x && docker push "$repo:$version-dind" )
	( set -x && docker push "$repo:$version-git" )
	if [ "$version" = 'master' ]; then
		( set -x && docker push "$repo:latest" )
		( set -x && docker push "$repo:dind" )
		( set -x && docker push "$repo:git" )
	fi
done
