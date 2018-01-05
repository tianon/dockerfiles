#!/bin/bash
set -eo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

mirror='https://packagecloud.io/slacktechnologies/slack/debian'
suites=( jessie )
components=( main )
arch='amd64'

latestVersion=
for suite in "${suites[@]}"; do
	for component in "${components[@]}"; do
		url="$mirror/dists/$suite/$component/binary-$arch/Packages.bz2"
		versions=( $(
			wget -qO- "$url" \
				| bunzip2 \
				| awk -F ': ' '
					$1 == "Package" { pkg = $2 }
					$1 == "Version" && pkg == "slack-desktop" { print $2 }
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
sed -ri 's/^(ENV SLACK_VERSION) .*/\1 '"$latestVersion"'/' Dockerfile
