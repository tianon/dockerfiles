#!/usr/bin/env bash
set -Eeuo pipefail

_libsDir="$(dirname "$BASH_SOURCE")"
source "$_libsDir/hooks.sh"
unset _libsDir

pypi() {
	local package="$1"; shift
	[ -n "$package" ]

	local json
	json="$(wget -qO- --header 'Accept: application/vnd.pypi.simple.v1+json' "https://pypi.org/simple/$package/")" || return "$?"

	local versions
	versions="$(jq <<<"$json" -r '.versions | reverse | map(@sh) | join(" ")')" || return "$?"
	eval "versions=( $versions )"

	(
		local pypi
		versions_loop_setvars() {
			version="$1"
			pypi="$(wget -qO- "https://pypi.org/pypi/$package/$version/json")" || return "$?"
			json="$(jq -n --arg version "$version" '{ version: $version }')" || return "$?"
		}
		hook_pypi-no-yanked() {
			local yanked
			yanked="$(jq <<<"$pypi" '.info.yanked')" || return "$?"
			[ "$yanked" = 'false' ]
		}
		hook_pypi-add-python-version() {
			jq <<<"$pypi" -c '
				.info.classifiers
				| map(
					capture("^(?:Programming Language :: )?Python :: (?<python>[0-9]+[.][0-9]+)$")
					| .python
				)
				| sort_by(
					split(".")
					| map(tonumber)
				)
				| .[-1] // empty
				| {
					python: { version: . },
				}
			'
		}
		versions_hooks=( hook_pypi-no-yanked hook_pypi-add-python-version "${versions_hooks[@]}" )
		versions_loop 'pypi' "$package" "${versions[@]}"
	)
}
