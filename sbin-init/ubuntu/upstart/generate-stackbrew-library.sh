#!/bin/bash
set -e

declare -A aliases
aliases=(
	[14.04]='latest'
)

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( */ )
versions=( "${versions[@]%/}" )
url='git://github.com/tianon/dockerfiles'
dir='sbin-init/ubuntu/upstart'

echo '# maintainer: Tianon Gravi <admwiggin@gmail.com> (@tianon)'

for version in "${versions[@]}"; do
	commit="$(git log -1 --format='format:%H' -- "$version")"
	versionAliases=( $version $(cat "$version/aliases" 2>/dev/null || true) ${aliases[$version]} )
	
	echo
	for va in "${versionAliases[@]}"; do
		echo "$va: ${url}@${commit} $dir/$version"
	done
done
