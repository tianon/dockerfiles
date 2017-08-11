#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

latest="$(
	curl -fsSL 'https://pkg.jenkins.io/debian-stable/binary/Packages.gz' \
		| gunzip \
		| awk -F ': ' '
			$1 == "Package" { pkg = $2 }
			pkg == "jenkins" && $1 == "Version" { print $2 }
		' \
		| sort -rV \
		| head -n1
)"
set -x
sed -ri 's/^(ENV JENKINS_VERSION) .*/\1 '"$latest"'/' Dockerfile
