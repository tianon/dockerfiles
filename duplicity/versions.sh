#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/pypi.sh"

versions_hooks+=( hook_no-prereleases )

export TIANON_PYTHON_FROM_TEMPLATE='python:%%PYTHON%%-alpine3.19'

json="$(
	hook_bad-duplicity-versions() {
		case "$3" in
			2.0.0 | 2.0.2) return 1 ;; # https://gitlab.com/duplicity/duplicity/-/issues/746
		esac
	}
	versions_hooks+=( hook_bad-duplicity-versions )
	pypi 'duplicity'
)"
# TODO b2sdk pinning

jq <<<"$json" '.' > versions.json
