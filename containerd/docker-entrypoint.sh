#!/usr/bin/env bash
set -Eeuo pipefail

# no arguments or first arg is `-f` or `--some-option`
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	set -- containerd "$@"
fi

# if we're not root, let's adjust all the "uid" and "gid" parameters of the config to whatever our current user is (so we avoid "chown" permission errors)
if [ "$1" = 'containerd' ]; then
	uid="$(id -u)"
	if [ "$uid" != 0 ]; then
		shift

		if ! configDump="$(containerd config dump 2>/dev/null)"; then
			configDump="$(containerd --config /dev/null config dump)"
		fi

		gid="$(id -g)"

		exec containerd --config <(
			awk <<<"$configDump" -v uid="$uid" -v gid="$gid" '
				$1 == "uid" { gsub(/=.+$/, "= " uid) }
				$1 == "gid" { gsub(/=.+$/, "= " gid) }
				{ print }
			'
		) "$@"
	fi

	# we're root *and* running containerd, so let's do a few crude checks for whether the dind script has already run (or whether we should automatically run it)
	if [ -z "${container:-}" ] && ! mountpoint -q /tmp; then
		# TODO somehow also detect --privileged ?
		set -- dind "$@"
	fi
fi

exec "$@"
