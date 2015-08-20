#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

latest="$(curl -fsSL 'http://pkg.jenkins-ci.org/debian/binary/Packages.gz' | gunzip | awk -F ': ' '$1 == "Package" { pkg = $2 } pkg == "jenkins" && $1 == "Version" { print $2; exit }')"
set -x
sed -ri 's/^(ENV JENKINS_VERSION) .*/\1 '"$latest"'/' Dockerfile
