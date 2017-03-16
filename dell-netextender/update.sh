#!/bin/bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

# https://aur.archlinux.org/packages/netextender/
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=netextender
current="$(
	curl -fsSL 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=netextender' \
		| tac|tac \
		| awk -F '=' '$1 == "pkgver" { print $2; exit }'
)"
# thanks to the AUR maintainers for doing the hard work O:)

set -x
sed -ri 's/^(ENV DELL_NETEXTENDER_VERSION) .*/\1 '"$current"'/' Dockerfile
