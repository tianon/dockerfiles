#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

variants=(
	''
	'rc'

	#'1.7' # TODO add this once 2.0 is stable
	'1.6'

	# TODO add this when I figure out a clean way to do something more akin to a "weekly snapshot" or something so it doesn't have an update every single day (see also "buildkit")
	#'dev'
)

json='{}'

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

for variant in "${variants[@]}"; do
	export variant

	containerd="$(
		# NOTE: this is using the funny () case syntax because there's a bug in the Bash 5.1 in Ubuntu Jammy (that's fixed in the Bash 5.2 in Debian Bookworm) which for some reason fails to parse these subshells correctly otherwise
		case "$variant" in
			(rc)
				hook_prereleases-only() { ! hook_no-prereleases "$@"; }
				versions_hooks+=( hook_prereleases-only )
				;;

			([0-9]*.[0-9]*)
				hook_variant-version() {
					case "$3" in "$variant" | "$variant".*) return 0 ;; esac
					return 1
				}
				versions_hooks+=( hook_no-prereleases hook_variant-version )
				;;

			('')
				versions_hooks+=( hook_no-prereleases )
				;;

			(*) echo >&2 "error: unknown variant: '$variant'"; exit 1 ;;
		esac

		# this should always be last since it's really heavy (so we need to pre-filter as much as we can)
		versions_hooks+=( hook_containerd-arches )

		git-tags 'https://github.com/containerd/containerd.git'
	)"
	[ -n "$containerd" ]
	json="$(jq <<<"$json" --argjson containerd "$containerd" '
		if env.variant == "" then . else .[env.variant] end += $containerd
		| .variants += [ env.variant ]
	')"
done

versions_hooks+=( hook_no-prereleases )

runc="$(
	hook_runc-arches() {
		local version="$3"
		local sha256 urlBase="https://github.com/opencontainers/runc/releases/download/v$version"
		sha256="$(wget -qO- "$urlBase/runc.sha256sum")" || return 1
		local json
		json="$(jq <<<"$sha256" -csR --arg version "$version" --arg urlBase "$urlBase" -L"$dir/../.libs" '
			include "lib"
			;
			split("\n")
			| map(
				capture("^(?<sha256>[0-9a-f]{64}) [ *](?<file>runc.(?<arch>[^.]+))$")
				| .arch |= {
					# https://github.com/opencontainers/runc/releases
					# https://github.com/opencontainers/runc/blob/main/script/lib.sh
					# explicit in our full supported list here so new things do not bork us (like switching to armvN style names; https://github.com/opencontainers/runc/pull/4034#issuecomment-1738206927)
					"386": "i386",
					amd64: "amd64",
					arm64: "arm64v8",
					# TODO if version is 1.2 or higher, we should add armel = arm32v5 (https://github.com/opencontainers/runc/pull/4034)
					armhf: "arm32v7", # in 1.2+, this is _technically_ arm32v6, but that is not a Debian arch which is what this image targets, so we will quietly remap it here
					ppc64le: "ppc64le",
					riscv64: "riscv64",
					s390x: "s390x",
				}[.]
				| select(.arch)
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

jq <<<"$json" --argjson runc "$runc" --argjson dind "$dind" '
	.runc = $runc
	| .dind = $dind
' > versions.json
