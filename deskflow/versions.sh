#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

export debian='trixie' # TODO scrape this somehow?

json="$(
	hook_deskflow() {
		local tag
		tag="$(jq <<<"$json" -r '.tag')" || return "$?"

		[ "$tag" != 'continuous' ] || return "$?"

		local urlBase="https://github.com/deskflow/deskflow/releases/download/$tag"

		local sums
		sums="$(wget -qO- "$urlBase/sums.txt")" || return "$?"

		jq <<<"$sums" -Rsc -L../.libs --arg urlBase "$urlBase" '
			include "lib"
			;
			(
				[
					"^(?<sha256>[0-9a-f]{64})",
					"(  | [*])",
					"(?<file>",
						"(deskflow-)?",
						"[0-9.-]+", # version
						"-debian-" + env.debian + "-",
						"(?<arch>[^. ]+)", # x86_64, aarch64
						"[.]deb",
					")$"
				] | join("")
			) as $regex
			| rtrimstr("\n")
			| split("\n")
			| map(
				capture($regex)
				| (
					{
						"x86_64": "amd64",
						"aarch64": "arm64v8",
					}[.arch]
					// error("unknown arch: " + .arch)
				) as $arch
				| { ($arch): {
					url: ($urlBase + "/" + .file),
					sha256: .sha256,
					dpkgArch: ($arch | deb_arch),
				} }
			)
			| { debian: env.debian, arches: add }
		' || return "$?"
	}
	versions_hooks+=( hook_deskflow )
	git-tags 'https://github.com/deskflow/deskflow.git'
)"

jq <<<"$json" '.' > versions.json
