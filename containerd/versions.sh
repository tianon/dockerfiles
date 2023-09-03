#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

containerd="$(
	# https://github.com/containerd/containerd/releases
	upstreamArches=(
		amd64
		arm64v8
		ppc64le
		riscv64
		s390x
		windows-amd64
	)
	hook_containerd-arches() {
		local version="$3"
		local json='{}' arch
		for arch in "${upstreamArches[@]}"; do
			local upstreamArch
			case "$arch" in
				arm64v8) upstreamArch='linux-arm64' ;;
				windows-*) upstreamArch="$arch" ;;
				*) upstreamArch="linux-$arch" ;;
			esac
			local sha256 url="https://github.com/containerd/containerd/releases/download/v$version/containerd-$version-$upstreamArch.tar.gz"
			sha256="$(wget -qO- "$url.sha256sum")" || continue
			sha256="${sha256%% *}"
			json="$(jq <<<"$json" -c --arg arch "$arch" --arg url "$url" --arg sha256 "$sha256" -L"$dir/../.libs" '
				include "lib"
				;
				.arches[$arch] = {
					url: $url,
					sha256: $sha256,
					dpkgArch: ($arch | deb_arch),
				}
			')"
		done
		jq <<<"$json" -e '.arches? | has("amd64") and has("arm64v8")' > /dev/null || return 1
		[ "$json" = '{}' ] || printf '%s\n' "$json"
	}
	versions_hooks+=( hook_containerd-arches )

	git-tags 'https://github.com/containerd/containerd.git'
)"

runc="$(
	hook_runc-arches() {
		local version="$3"
		local sha256 urlBase="https://github.com/opencontainers/runc/releases/download/v$version"
		sha256="$(wget -qO- "$urlBase/runc.sha256sum")" || return 1
		local json
		json="$(jq <<<"$sha256" -csR --arg urlBase "$urlBase" -L"$dir/../.libs" '
			include "lib"
			;
			split("\n")
			| map(
				capture("^(?<sha256>[0-9a-f]{64}) [ *](?<file>runc.(?<arch>[^.]+))$")
				| select(.arch != "armel") # https://github.com/opencontainers/runc/blob/8feecba2bb293267c0dee854c86d291852b86388/script/lib.sh#L14-L16 ("arm-linux-gnueabi" + GOARM=6 does not make a ton of sense but also does not map to a Debian arch, so we do not need it)
				| .arch |= ({
					arm64: "arm64v8",
					armhf: "arm32v7",
				}[.] // .)
				| { (.arch): {
					url: ($urlBase + "/" + .file),
					sha256: .sha256,
					dpkgArch: (.arch | deb_arch),
				} }
			)
			| { arches: add }
		')" || return 1
		jq <<<"$json" -e '.arches | has("amd64") and has("arm64v8")' > /dev/null || return 1
		printf '%s\n' "$json"
	}
	versions_hooks+=( hook_runc-arches )

	git-tags 'https://github.com/opencontainers/runc.git'
)"

dind="$(github-file-commit 'moby/moby' 'HEAD' 'hack/dind')"

jq <<<"$containerd" --argjson runc "$runc" --argjson dind "$dind" '
	.runc = $runc
	| .dind = $dind
' > versions.json
