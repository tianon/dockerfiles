#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

branch="$(awk '$1 == "ENV" && $2 == "GOLANG_BRANCH" { print $3; exit }' Dockerfile)"
commit="$(git ls-remote https://github.com/golang/go.git "refs/heads/$branch" | cut -d$'\t' -f1)"

set -x
sed -ri 's/^(ENV GOLANG_COMMIT) .*/\1 '"$commit"'/' Dockerfile
