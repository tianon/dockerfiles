#!/usr/bin/env bash
set -Eeuo pipefail

latest="$(git ls-remote --tags https://github.com/prometheus/prometheus.git | cut -d/ -f3 | cut -d^ -f1 | grep -v -E "(beta|rc)" | sort -V | tail -1)"
latest="${latest#v}"

dir="$(dirname "$BASH_SOURCE")"
(
	set -x
	sed -ri \
		-e 's/^(ENV PROMETHEUS_VERSION) .*/\1 '"$latest"'/' \
		"$dir/Dockerfile"
)

for up in "$dir"/*/update.sh; do
	(
		set -x
		cd "$(dirname "$up")"
		./update.sh
	)
done
