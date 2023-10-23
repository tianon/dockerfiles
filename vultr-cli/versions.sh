#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

json="$(
	hook_vultr-sha256() {
		local tag
		tag="$(jq <<<"$json" -r '.tag')" || return "$?"

		local urlBase="https://github.com/vultr/vultr-cli/releases/download/$tag"

		local checksums
		checksums="$(wget -qO- "$urlBase/vultr-cli_v${version}_checksums.txt")" || return "$?"

		jq <<<"$checksums" -Rsc -L../.libs --arg urlBase "$urlBase" '
			include "lib"
			;
			(
				[
					"^(?<sha256>[0-9a-f]{64})",
					"(  | [*])",
					"(?<file>",
						"(vultr-cli_)?",
						"v?[0-9.-]+",
						"_(?i:(?<os>linux|windows|macos))_",
						"(?<arch>[^_. ]+)",
						"[.](tar[.]gz|zip)",
					")$"
				] | join("")
			) as $regex
			| rtrimstr("\n")
			| split("\n")
			| map(
				capture($regex)
				| (
					(
						{
							"linux": "",
							"macos": "darwin-",
							"windows": "windows-",
						}[.os | ascii_downcase]
						// empty
					) + (
						{
							"amd64": "amd64",
							"arm32-v6": "arm32v6",
							"arm32-v7": "arm32v7",
							"arm64": "arm64v8",
						}[.arch]
						// empty
					)
				) as $arch
				| { ($arch): {
					url: ($urlBase + "/" + .file),
					sha256: .sha256,
					apkArch: ($arch | apk_arch),
				} }
			)
			| { arches: add }
		' || return "$?"
	}
	versions_hooks+=( hook_vultr-sha256 )
	git-tags 'https://github.com/vultr/vultr-cli.git'
)"

jq <<<"$json" '.' > versions.json
