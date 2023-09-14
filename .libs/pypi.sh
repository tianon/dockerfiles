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
			local pythons
			pythons="$(
				jq <<<"$pypi" -r '
					.info.classifiers
					| map(
						capture("^(?:Programming Language :: )?Python :: (?<python>[0-9]+[.][0-9]+)$")
						| .python
					)
					| sort_by(
						split(".")
						| map(tonumber)
					)
					| reverse
					| map(@sh)
					| join(" ")
				'
			)"
			eval "pythons=( $pythons )"
			local python pythonTemplate="${TIANON_PYTHON_FROM_TEMPLATE:-python:%%PYTHON%%}"
			for python in "${pythons[@]}"; do
				local from="${pythonTemplate//%%PYTHON%%/$python}"
				local arches
				if ! arches="$(bashbrew remote arches --json "$from")"; then
					echo >&2 "skipping $from ..."
					continue
				fi
				jq -nc --arg python "$python" --arg from "$from" --argjson arches "$arches" '{ python: { version: $python, from: $from, arches: ($arches.arches | keys) } }'
				return 0
			done
			return 1 # TODO should this be more lenient of packages missing metadata? (or whose template results in no matching Pythons 😬)
		}
		versions_hooks=( hook_pypi-no-yanked hook_pypi-add-python-version "${versions_hooks[@]}" )
		versions_loop 'pypi' "$package" "${versions[@]}"
	)
}
