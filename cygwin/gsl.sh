#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dockerfiles=( $(ls -1 Dockerfile.* | tac) )
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry

for dockerfile in "${dockerfiles[@]}"; do
	version="${dockerfile#Dockerfile.}"
	tagsEntry "$dir" "win$version"
	cat <<-EOF
		Architectures: windows-amd64
		Constraints: windowsservercore-$version
		SharedTags: latest
	EOF
done
