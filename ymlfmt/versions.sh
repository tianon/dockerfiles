#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/pypi.sh"

versions_hooks+=( hook_no-prereleases )

export TIANON_PYTHON_FROM_TEMPLATE='python:%%PYTHON%%-alpine3.19'

json="$(pypi 'ruamel.yaml')"

jq <<<"$json" '.' > versions.json
