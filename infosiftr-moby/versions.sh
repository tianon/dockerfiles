#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"
source "$dir/../.libs/git.sh"

debian='bookworm'
json="$(jq -nc --arg debian "$debian" '{ debian: { version: $debian } }')"

uri='https://apt.tianon.xyz/moby'
component='main'

for suite in \
	"$debian" \
	unstable \
; do
	for binpkg in \
		engine \
		containerd \
		runc \
		cli \
		cli-plugin-buildx \
	; do
		cjson="$(
			package="moby-$binpkg"
			if [ "$suite" = 'unstable' ]; then
				arch='riscv64'
			fi
			deb-repo
		)"
		json="$(jq <<<"$json" -c --arg suite "$suite" --arg binpkg "$binpkg" --argjson cjson "$cjson" '
			if $suite == "unstable" then
				.["unstable"][$binpkg] = $cjson
			else
				.[$binpkg] = $cjson
			end
		')"
	done
done

dind="$(github-file-commit 'moby/moby' 'HEAD' 'hack/dind')"

jq <<<"$json" --argjson dind "$dind" '
	def upstream_version:
		if index(":") then
			split(":")[1]
		else . end
		| split("-")[0]
	;
	.dind = $dind
	| (.engine.version | upstream_version) as $eng
	| (.cli.version | upstream_version) as $cli
	| (.unstable.engine.version | upstream_version) as $ueng
	| (.unstable.cli.version | upstream_version) as $ucli
	| if $eng == $cli and $eng == $ueng and $eng == $ucli then
		.version = $eng
	else . end
	| .variants = [ "", "unstable" ] # make sure "apply-templates.sh" creates "Dockerfile.unstable" too
' > versions.json
