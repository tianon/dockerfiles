#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

urls="$(
	curl -fsSL --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36 Edg/101.0.1210.26' 'https://www.speedtest.net/apps/cli' \
		| grep -oE '"https?://[^"]+/ookla-speedtest-[^"/]+-linux-[^"/]+[.]tgz"' \
		| cut -d'"' -f2
)"

json="$(jq <<<"$urls" -Rsc -L../.libs '
	include "lib"
	;
	rtrimstr("\n")
	| split("\n")
	| map(
		. as $url
		| capture("ookla-speedtest-(?<version>[^/]+)-linux-(?<arch>[^/]+)[.]tgz")
		| {
			aarch64: "arm64v8",
			armel: "arm32v5", # Ookla "armel" is armv5
			armhf: ("arm32v6", "arm32v7"), # Ookla "armhf" is armv6
			i386: "i386",
			x86_64: "amd64",
		}[.arch] as $arch
		| { ($arch): {
			url: $url,
			apkArch: ($arch | apk_arch),
			version: .version,
		} }
	)
	| add
	| .amd64.version as $version
	| {
		version: .amd64.version,
		arches: (
			to_entries
			| map(
				# TODO instead of "select", we should "error"
				select(.value.version == $version)
				| del(.value.version)
			)
			| from_entries
		),
	}
')"

version="$(jq <<<"$json" -r '.version')"
echo >&2 "speedtest: $version"

jq <<<"$json" '.' > versions.json
