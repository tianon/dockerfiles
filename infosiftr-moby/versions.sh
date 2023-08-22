#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"
source "$dir/../.libs/git.sh"

json='{}'
for comp in \
	cli \
	cli-plugin-buildx \
	containerd \
	engine \
	runc \
; do
	cjson="$(
		uri='https://apt.tianon.xyz/moby'
		suite='bookworm'
		component='main'
		package="moby-$comp"
		deb-repo
	)"
	json="$(jq <<<"$json" -c --arg comp "$comp" --argjson cjson "$cjson" '.[$comp] = $cjson')"
done

dind="$(github-file-commit 'moby/moby' 'HEAD' 'hack/dind')"

jq <<<"$json" --argjson dind "$dind" '.dind = $dind' > versions.json
