#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

# https://pages.github.com/versions/
json="$(wget -qO- 'https://pages.github.com/versions.json')"

json="$(jq <<<"$json" -c '
	{
		version: ."github-pages",
		ruby: (
			.ruby
			| capture("^(?<version>[0-9]+[.][0-9]+)[.]")
		),
		nokogiri: {
			version: .nokogiri,
		},
	}
')"

version="$(jq <<<"$json" -r '.version')"
echo >&2 "github-pages: $version"

jq <<<"$json" '.' > versions.json
