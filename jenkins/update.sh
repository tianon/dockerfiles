#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

for up in */update.sh; do
	( set -x && cd "$(dirname "$up")" && ./update.sh )
done
