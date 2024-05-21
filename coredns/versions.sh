#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

# 🙃 (https://github.com/coredns/coredns/releases/tag/v1.11.3 is a normal release, but marked pre-release on GH)
hook_no-github-prereleases() {
	local version="$3"
	if wget -qO- "https://github.com/coredns/coredns/releases/tag/v${version}" | grep -F 'Pre-release' > /dev/null; then
		return 1
	fi
	return 0
}
versions_hooks+=( hook_no-github-prereleases )

# https://github.com/coredns/coredns/releases
upstreamArches=(
	amd64
	# TODO arm32v? ("linux_arm")
	arm64v8
	mips64le
	ppc64le
	riscv64
	s390x
	windows-amd64
)
hook_coredns-arches() {
	local version="$3"
	local json='{}' arch
	for arch in "${upstreamArches[@]}"; do
		local upstreamArch
		case "$arch" in
			arm64v8) upstreamArch='linux_arm64' ;;
			windows-*) upstreamArch="${arch/-/_}" ;;
			*) upstreamArch="linux_$arch" ;;
		esac
		local sha256 url="https://github.com/coredns/coredns/releases/download/v${version}/coredns_${version}_${upstreamArch}.tgz"
		sha256="$(wget -qO- "$url.sha256")" || continue
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
versions_hooks+=( hook_coredns-arches )

coredns="$(
	git-tags 'https://github.com/coredns/coredns.git'
)"

jq <<<"$coredns" . > versions.json
