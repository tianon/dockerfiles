#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"

upstream="$(wget -qO- 'https://kernel.org/releases.json')"

linux="$(jq <<<"$upstream" -r 'first(.releases[] | select(.moniker == "stable")) // error("failed to scrape linux version!")')"
export linux

# TODO scrape https://cdn.kernel.org/pub/linux/kernel/v6.x/sha256sums.asc for checksum

version="$(jq <<<"$linux" -r '.version')"
echo >&2 "nolibc linux: $version"

jq -n -L"$dir/../.libs" '
	include "lib"
	;
	{
		linux: (env.linux | fromjson),
		arches: (
			{
				# TODO auto-detect these somehow?
				# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/include/nolibc?h=linux-rolling-stable (arch-*.h)
				# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/include/nolibc/Makefile?h=linux-rolling-stable (ARCH, SUBARCH, nolibc_arch)
				# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/scripts/subarch.include?h=linux-rolling-stable (SUBARCH)
				amd64:    { nolibc: "x86_64" },
				arm32v5:  { nolibc: "arm" },
				arm32v6:  { nolibc: "arm" },
				arm32v7:  { nolibc: "arm" },
				arm64v8:  { nolibc: "arm64" },
				i386:     { nolibc: "i386" },
				mips64le: { nolibc: "mips" },
				ppc64le:  { nolibc: "powerpc" },
				riscv64:  { nolibc: "riscv" },
				s390x:    { nolibc: "s390" },
			}
			| with_entries(
				.value.dpkg = (.key | deb_arch)
				| .value.apk = (.key | apk_arch)
				| .value |= map_values(select(.))
			)
		),
	}
' > versions.json
