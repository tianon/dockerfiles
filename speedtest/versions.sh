#!/usr/bin/env bash
set -Eeuo pipefail

urls="$(
	wget -qO- 'https://www.speedtest.net/apps/cli' \
		| grep -oE '"https?://[^"]+/ookla-speedtest-[^"/]+-linux-[^"/]+[.]tgz"' \
		| cut -d'"' -f2
)"

json="$(jq <<<"$urls" -Rsc '
	rtrimstr("\n")
	| split("\n")
	| map(
		. as $url
		| match("ookla-speedtest-([^/]+)-linux-([^/]+)[.]tgz")
		| .captures[0].string as $version
		| .captures[1].string as $arch
		| {
			aarch64: "arm64v8",
			armel: "arm32v5", # Ookla "armel" is armv5
			armhf: "arm32v6", # Ookla "armhf" is armv6
			i386: "i386",
			x86_64: "amd64",
		}[$arch] as $arch
		| { ($arch): { url: $url, version: $version } }
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

jq <<<"$json" -S . > versions.json
