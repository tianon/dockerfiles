#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../../.libs/git.sh"

json="$(git-tags 'https://github.com/prometheus/alertmanager.git')"

version="$(jq <<<"$json" -r '.version')"
sha256="$(wget -qO- "https://github.com/prometheus/alertmanager/releases/download/v${version}/sha256sums.txt")"
# TODO parse result, put into versions.json

jq <<<"$json" -S 'del(.tag)' > versions.json
