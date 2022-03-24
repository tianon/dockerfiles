#!/usr/bin/env bash
set -Eeuo pipefail

pypi() {
	local package="$1"; shift
	[ -n "$package" ]

	local json version
	json="$(wget -qO- "https://pypi.org/pypi/$package/json")"
	version="$(jq <<<"$json" -r '.info.version')" # TODO some way to only get versions matching a particular string? ("1.14.x" etc. instead of just latest)

	echo >&2 "pip $package: $version"

	jq <<<"$json" -c '
		.info
		| (
			.classifiers
			| map(
				match("^(?:Programming Language :: )?Python :: ([0-9]+[.][0-9]+)$")
				| .captures[0].string
				| split(".")
				| map(tonumber)
			)
			| sort[-1]
			| join(".")
		) as $python
		| {
			version: .version,
			python: { version: $python },
		}
	'
}
