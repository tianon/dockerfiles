#!/bin/bash
set -eo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

# "tac|tac" for http://stackoverflow.com/a/28879552/433558
dindLatest="$(curl -fsSL 'https://github.com/docker/docker/commits/master/hack/dind.atom'| tac|tac | awk -F ' *[<>/]+' '$2 == "id" && $3 ~ /Commit/ { print $4; exit }')"

#masterCommit="$(curl -fsSL 'https://master.dockerproject.org/commit')"
masterCommit="$(git ls-remote https://github.com/docker/docker.git refs/heads/master | cut -d$'\t' -f1)"

declare -A versions=(
	[master]="$(curl -fsSL 'https://master.dockerproject.org/version')"
	#[experimental]="$(curl -fsSL 'http://experimental.docker.com.s3.amazonaws.com/latest')"
)
declare -A urls=(
	[master]="https://master.dockerproject.org/linux/x86_64/docker-${versions[master]}.tgz"
	#[experimental]="http://experimental.docker.com.s3.amazonaws.com/builds/Linux/x86_64/docker-${versions[experimental]}.tgz"
)
declare -A sha256s=(
	[master]="$(curl -fsSL "${urls[master]}.sha256" | cut -d' ' -f1)"
	#[experimental]="$(curl -fsSL "${urls[experimental]}.sha256" | cut -d' ' -f1)"
)

version='master'
(
	set -x
	sed -ri '
		s/^(ENV DOCKER_VERSION) .*/\1 '"${versions[$version]}"'/;
		s!^(ENV DOCKER_URL) .*!\1 '"${urls[$version]}"'!;
		s/^(ENV DOCKER_SHA256) .*/\1 '"${sha256s[$version]}"'/;
		#s/^(ENV DIND_COMMIT) .*/\1 '"$dindLatest"'/;
		s/^(FROM .*docker.*):.*/\1:'"$version"'/;
	' Dockerfile */Dockerfile
	sed -ri \
		-e 's!^(ENV DOCKER_GITCOMMIT) .*!\1 '"$masterCommit"'!' \
		Dockerfile.build
)
