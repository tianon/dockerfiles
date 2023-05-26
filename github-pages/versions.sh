#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

# https://pages.github.com/versions/
json="$(wget -qO- 'https://pages.github.com/versions.json')"

json="$(jq <<<"$json" -c '
	{
		version: ."github-pages",
		ruby: {
			version: (
				.ruby
				| match("^([0-9]+[.][0-9]+)[.]")
				| .captures[0].string
			),
		},
	}
')"

version="$(jq <<<"$json" -r '.version')"
echo >&2 "github-pages: $version"

jq <<<"$json" -S . > versions.json
