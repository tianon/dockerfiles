#!/usr/bin/env bash
set -Eeuo pipefail

latest="$(git ls-remote --tags https://github.com/containerd/containerd.git | cut -d/ -f3 | cut -d^ -f1 | grep -vE -- '-(rc|alpha|beta)' | sort -V | tail -1)"
latest="${latest#v}"

runc="$(git ls-remote --tags https://github.com/opencontainers/runc.git | cut -d/ -f3 | cut -d^ -f1 | sort -V | tail -1)"
runc="${runc#v}"

dir="$(dirname "$BASH_SOURCE")"
set -x
sed -ri \
	-e 's/^(ENV CONTAINERD_VERSION) .*/\1 '"$latest"'/' \
	-e 's/^(ENV RUNC_VERSION) .*/\1 '"$runc"'/' \
	"$dir/Dockerfile"
