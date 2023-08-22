#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

versions_hooks+=( hook_no-prereleases )

containerd="$(git-tags 'https://github.com/containerd/containerd.git')"
runc="$(git-tags 'https://github.com/opencontainers/runc.git')"
dind="$(github-file-commit 'moby/moby' 'HEAD' 'hack/dind')"

jq <<<"$containerd" --argjson runc "$runc" --argjson dind "$dind" '
	.runc = $runc
	| .dind = $dind
' > versions.json
