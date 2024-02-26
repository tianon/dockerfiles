#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"

upstream="$(wget -qO- 'https://kernel.org/releases.json')"

# TODO save more interesting data than just version, like .released.timestamp and .source (as url)
linux="$(jq <<<"$upstream" -r 'first(.releases[].version | select(startswith("6.7."))) // error("failed to scrape linux version!")')" # TODO decide whether we'd be OK to just take ".latest_stable.version" instead
export linux

echo >&2 "nolibc linux: $linux"

jq -n -L"$dir/../.libs" '
	include "lib"
	;
	{
		linux: { version: env.linux },
		arches: (
			{
				# TODO auto-detect these somehow?
				# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/include/nolibc?h=linux-rolling-stable (arch-*.h)
				# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/include/nolibc/Makefile?h=linux-rolling-stable (ARCH, SUBARCH, nolibc_arch)
				# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/scripts/subarch.include?h=linux-rolling-stable (SUBARCH)
				amd64: { nolibc: "x86_64" },
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
