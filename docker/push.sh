#!/bin/bash
set -e

repo='tianon/docker-master'

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( */ )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

token="$(curl -fsSL -o /dev/null -D- -H 'X-Docker-Token: true' "https://index.docker.io/v1/repositories/$repo/images" | tr -d '\r' | awk -F ': *' '$1 == "X-Docker-Token" { print $2 }')"
IFS=$'\n'
tags=( $(curl -fsSL -H "Authorization: Token $token" "https://registry-1.docker.io/v1/repositories/$repo/tags" | sed -r 's/^[{]"|"[}]$//g' | awk -v RS='", "' -F '": "' '{ print $1, $2 }') )
unset IFS

declare -A images=()
for tagIdsF in "${tags[@]}"; do
	tagIds=( $tagIdsF )
	tag="${tagIds[0]}"
	tagId="${tagIds[1]}"
	images["$repo:$tag"]="$tagId"
done

smart_push() {
	hubId="${images[$1]}"
	localId="$(docker inspect -f '{{.Id}}' "$1")"
	if [ -z "$hubId" -o "$hubId" != "$localId" ]; then
		( set -x && docker push "$1" )
	fi
}

for version in "${versions[@]}"; do
	smart_push "$repo:$version"
	smart_push "$repo:$version-dind"
	smart_push "$repo:$version-git"
	if [ "$version" = 'master' ]; then
		smart_push "$repo:latest"
		smart_push "$repo:dind"
		smart_push "$repo:git"
	fi
done
