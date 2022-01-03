#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

for up in */update.sh; do
	dir="$(dirname "$up")"
	( set -x && cd "$dir" && ./update.sh )
done
