#!/usr/bin/env bash
set -Eeuo pipefail

# usage:
#   versions_loop_setvars() { ...; } # something that takes one one loop var and sets "version" and "json" appropriately
#   versions_loop 'static-type' "$identifier" "${loopers[@]}"
#   unset versions_loop_setvars # optional, but good practice -- alternatively, define/invoke in a subshell
declare -ag versions_hooks # a list of function names
versions_loop() {
	local type="$1"; shift
	local identifier="$1"; shift

	local loop version json found=
	for loop; do
		versions_loop_setvars "$loop" || return "$?"

		local extra versions_hook
		for versions_hook in "${versions_hooks[@]}"; do
			if ! extra="$("$versions_hook" "$type" "$identifier" "$version" "$json")"; then
				echo >&2 "skipping $type $identifier: $version (${versions_hook#hook_})"
				continue 2
			fi
			if [ -n "$extra" ]; then
				json="$(jq <<<"$json" --argjson extra "$extra" '. += $extra')" || return "$?"
			fi
		done

		found=1
		break
	done

	if [ -z "$found" ]; then
		echo >&2 "$type $identifier: not found!"
		return 1
	fi

	echo >&2 "$type $identifier: $version"

	printf '%s\n' "$json"
}

# usage:
#   versions_hooks+=( hook_no-prereleases )
hook_no-prereleases() {
	case "$3" in
		*[0-9.-]rc* | *[0-9.-]alpha* | *[0-9.-]beta* | *[0-9.-]rc* | *[0-9.-]dev*) return 1 ;;
	esac
}

# usage:
#   hook_pin_version='1.2.3'
#   versions_hooks+=( hook_pin-version )
hook_pin-version() {
	[ "$3" = "$hook_pin_version" ]
}
