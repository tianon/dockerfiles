#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"
source "$dir/../.libs/git.sh"

debian='trixie'
json="$(jq -nc --arg debian "$debian" '{ debian: { version: $debian } }')"

uri='https://apt.tianon.xyz/moby'
component='main'

for suite in \
	"$debian" \
	bookworm \
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
			if [ "$suite" = 'bookworm' ]; then
				arch='mips64el'
			fi
			deb-repo
		)"
		json="$(jq <<<"$json" -c --arg suite "$suite" --arg binpkg "$binpkg" --argjson cjson "$cjson" '
			if $suite == "bookworm" then
				.["bookworm"][$binpkg] = $cjson
			else
				.[$binpkg] = $cjson
			end
		')"
	done
done

dind="$(github-file-commit 'docker/docker' 'HEAD' 'hack/dind')"

jq <<<"$json" --argjson dind "$dind" '
	def upstream_version:
		if index(":") then
			split(":")[1]
		else . end
		| split("-")[0]
	;
	def v(v):
		v | split(".")
	;
	.dind = $dind
	| (.engine.version | upstream_version) as $eng
	| (.cli.version | upstream_version) as $cli
	| (.bookworm.engine.version | upstream_version) as $ueng
	| (.bookworm.cli.version | upstream_version) as $ucli
	| if v($eng) >= v($cli) and $eng == $ueng and v($eng) >= v($ucli) then
		.version = $eng
	else . end
	| .variants = [ "", "bookworm" ] # make sure "apply-templates.sh" creates "Dockerfile.bookworm" too
' > versions.json
