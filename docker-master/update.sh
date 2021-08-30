#!/usr/bin/env bash
set -Eeuo pipefail

dir="$(readlink -f "$BASH_SOURCE")"
dir="$(dirname "$dir")"
cd "$dir"

# "tac|tac" for http://stackoverflow.com/a/28879552/433558
dindLatest="$(
	wget -qO- 'https://github.com/moby/moby/commits/master/hack/dind.atom' \
		| tac|tac \
		| awk -F ' *[<>/]+' '$2 == "id" && $3 ~ /Commit/ { print $4; exit }'
)"

mobyCommit="$(git ls-remote https://github.com/moby/moby.git refs/heads/master | cut -d$'\t' -f1)"
cliCommit="$(git ls-remote https://github.com/docker/cli.git refs/heads/master | cut -d$'\t' -f1)"

# TODO multiarch?
baseUrl='https://download.docker.com/linux/static/nightly/x86_64'
tarball="$(
	wget -qO- "$baseUrl" \
		| grep -oE '"docker-[0-9.-]+(-[0-9a-f]+)?[.]tgz"' \
		| tail -1 | cut -d'"' -f2
)"
version="${tarball#docker-}"
version="${version%.tgz}"
url="$baseUrl/$tarball"
sha256="$(wget -qO- "$url" | sha256sum | cut -d' ' -f1)"

(
	set -x
	sed -ri '
		s/^(ENV DOCKER_VERSION) .*/\1 '"$version"'/;
		s!^(ENV DOCKER_URL) .*!\1 '"$url"'!;
		s/^(ENV DOCKER_SHA256) .*/\1 '"$sha256"'/;
		s/^(ENV DIND_COMMIT) .*/\1 '"$dindLatest"'/;
	' Dockerfile */Dockerfile
	sed -ri \
		-e 's!^(ENV MOBY_GITCOMMIT) .*!\1 '"$mobyCommit"'!' \
		-e 's!^(ENV CLI_GITCOMMIT) .*!\1 '"$cliCommit"'!' \
		Dockerfile.build
)
