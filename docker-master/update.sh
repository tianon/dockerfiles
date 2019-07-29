#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

# "tac|tac" for http://stackoverflow.com/a/28879552/433558
dindLatest="$(curl -fsSL 'https://github.com/docker/docker/commits/master/hack/dind.atom'| tac|tac | awk -F ' *[<>/]+' '$2 == "id" && $3 ~ /Commit/ { print $4; exit }')"

#masterCommit="$(curl -fsSL 'https://master.dockerproject.org/commit')"
masterCommit="$(git ls-remote https://github.com/docker/docker.git refs/heads/master | cut -d$'\t' -f1)"

version="$(curl -fsSL 'https://master.dockerproject.org/version')"
url='https://master.dockerproject.org/linux/x86_64/docker.tgz'
sha256="$(curl -fsSL "$url" | sha256sum | cut -d' ' -f1)"

(
	set -x
	sed -ri '
		s/^(ENV DOCKER_VERSION) .*/\1 '"$version"'/;
		s!^(ENV DOCKER_URL) .*!\1 '"$url"'!;
		s/^(ENV DOCKER_SHA256) .*/\1 '"$sha256"'/;
		s/^(ENV DIND_COMMIT) .*/\1 '"$dindLatest"'/;
	' Dockerfile */Dockerfile
	sed -ri \
		-e 's!^(ENV DOCKER_GITCOMMIT) .*!\1 '"$masterCommit"'!' \
		Dockerfile.build
)
