#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/yq.sh"

json='{}'
# "amd64" *must* be first in this list!
for arch in amd64 arm64; do
	export arch

	doc="$(
		# ugh I hate these appcast XML files 😭
		wget -qO- "https://desktop.docker.com/linux/main/$arch/appcast.xml" \
			| "$yq" --input-format xml --output-format json \
			| jq --raw-output '
				.rss.channel.item
				| if type == "object" then [ . ] else . end # normalize single-item vs multi-item
				| max_by(
					.enclosure."+@sparkle:shortVersionString"
					| split(".")
					| map(tonumber? // .)
				)
				| {
					version: .enclosure."+@sparkle:shortVersionString",
					build: .enclosure."+@sparkle:version",
					date: .pubDate,
					url: .enclosure."+@url",
				}
			'
	)"

	url="$(jq <<<"$doc" --raw-output '.url')"
	file="$(basename "$url")"
	url="$(dirname "$url")"
	sha256="$(
		wget -qO- "$url/checksums.txt" \
			| jq --raw-input --null-input --raw-output --arg file "$file" '
				first(
					inputs
					| split(" [ *]"; "")
					| select(.[1] == $file)
				)
				| .[0]
			'
	)"
	[ -n "$sha256" ]
	export sha256

	jq <<<"$doc" --raw-output '"docker-desktop (\(env.arch)): \(.version) (\(.build)) \(env.sha256)"'

	json="$(jq <<<"$json" -c --argjson doc "$doc" '
		# if these top-level keys are not set yet, they should be set from the first arch (which should be amd64)
		.version //= $doc.version
		| .build //= $doc.build
		| if $doc.version == .version then
			.arches[{
				arm64: "arm64v8",
			}[env.arch] // env.arch] = (
				$doc
				| del(.version)
				| .sha256 = env.sha256
				| .dpkgArch = env.arch
			)
		else . end
	')"
done

jq <<<"$json" '.' > versions.json
