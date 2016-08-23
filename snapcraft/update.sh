#!/bin/bash
set -eo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

mirror='http://archive.ubuntu.com/ubuntu'
suites=( xenial xenial-updates xenial-security )
#components=( main restricted universe )
components=( universe )
arch='amd64'

latestVersion=
for suite in "${suites[@]}"; do
	for component in "${components[@]}"; do
		url="$mirror/dists/$suite/$component/binary-$arch/Packages.xz"
		versions=( $(
			wget -qO- "$url" \
				| xz -d \
				| awk -F ': ' '
					$1 == "Package" { pkg = $2 }
					$1 == "Version" && pkg == "snapcraft" { print $2 }
				'
		) )
		for version in "${versions[@]}"; do
			if \
				[ -z "$latestVersion" ] \
				|| dpkg --compare-versions "$version" '>>' "$latestVersion" \
			; then
				latestVersion="$version"
			fi
		done
	done
done

set -x
sed -ri 's/^(ENV SNAPCRAFT_VERSION) .*/\1 '"$latestVersion"'/' Dockerfile
