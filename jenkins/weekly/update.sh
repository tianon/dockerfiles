#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

latest="$(
	curl -fsSL 'https://pkg.jenkins.io/debian/binary/Packages.gz' \
		| gunzip \
		| awk -F ': ' '
			$1 == "Package" { pkg = $2 }
			pkg == "jenkins" && $1 == "Version" { print $2 }
		' \
		| sort -rV \
		| head -n1
)"

echo "jenkins-weekly: $latest"

sed -ri 's/^(ENV JENKINS_VERSION) .*/\1 '"$latest"'/' Dockerfile
