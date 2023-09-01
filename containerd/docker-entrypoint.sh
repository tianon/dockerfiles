#!/usr/bin/env bash
set -Eeuo pipefail

# no arguments or first arg is `-f` or `--some-option`
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	set -- containerd "$@"
fi

# if we're not root, let's adjust all the "uid" and "gid" parameters of the config to whatever our current user is (so we avoid "chown" permission errors)
uid="$(id -u)"; gid="$(id -g)"
if [ "$uid" != 0 ] && [ "$1" = 'containerd' ]; then
	shift

	configDump=( containerd config dump )
	if ! "${configDump[@]}" &> /dev/null; then
		configDump=( containerd --config /dev/null config dump )
		"${configDump[@]}" > /dev/null
	fi

	exec containerd --config <(
		"${configDump[@]}" \
			| awk -v uid="$uid" -v gid="$gid" '
				$1 == "uid" { gsub(/=.+$/, "= " uid) }
				$1 == "gid" { gsub(/=.+$/, "= " gid) }
				{ print }
			'
	) "$@"
fi

exec "$@"
