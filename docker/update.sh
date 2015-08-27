#!/bin/bash
set -eo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

# "tac|tac" for http://stackoverflow.com/a/28879552/433558
dindLatest="$(curl -fsSL 'https://github.com/docker/docker/commits/master/hack/dind.atom'| tac|tac | awk -F '[[:space:]]*[<>/]+' '$2 == "id" && $3 ~ /Commit/ { print $4; exit }')"

#masterCommit="$(curl -fsSL 'https://master.dockerproject.org/commit')"

declare -A versions=(
	[master]="$(curl -fsSL 'https://master.dockerproject.org/version')"
	[experimental]="$(curl -fsSL 'https://experimental.docker.com/latest')"
)
declare -A urls=(
	[master]="https://master.dockerproject.org/linux/amd64/docker-${versions[master]}"
	[experimental]="https://experimental.docker.com/builds/Linux/x86_64/docker-${versions[experimental]}"
)
declare -A sha256s=(
	[master]="$(curl -fsSL "${urls[master]}.sha256" | cut -d' ' -f1)"
	[experimental]="$(curl -fsSL "${urls[experimental]}.sha256" | cut -d' ' -f1)"
)
declare -A tags=(
	[master]='latest'
)

for version in "${!versions[@]}"; do
	(
		set -x
		sed -ri '
			s/^(ENV DOCKER_VERSION) .*/\1 '"${versions[$version]}"'/;
			s!^(ENV DOCKER_URL) .*!\1 '"${urls[$version]}"'!;
			s/^(ENV DOCKER_SHA256) .*/\1 '"${sha256s[$version]}"'/;
			s/^(ENV DIND_COMMIT) .*/\1 '"$dindLatest"'/;
			s/^(FROM .*docker.*):.*/\1:'"${tags[$version]:-$version}"'/;
		' "$version/Dockerfile" "$version"/*/Dockerfile
	)
done
