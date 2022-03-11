#!/usr/bin/env bash
set -Eeuo pipefail

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"

"$dir/versions.sh" "$@"
"$dir/apply-templates.sh" "$@"
