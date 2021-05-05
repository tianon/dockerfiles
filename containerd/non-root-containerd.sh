#!/usr/bin/env bash
set -Eeuo pipefail

uid="$(id -u)"
gid="$(id -g)"
if [ "$uid" = 0 ]; then
	# if we're root, nothing special is required
	exec containerd "$@"
fi

# if we're not root, let's adjust all the "uid" and "gid" parameters of the config to whatever our current user is (so we avoid "chown" permission errors)
exec containerd --config <(
	containerd --config /dev/null config dump \
		| awk -v uid="$uid" -v gid="$gid" '
			$1 == "uid" { gsub(/=.+$/, "= " uid) }
			$1 == "gid" { gsub(/=.+$/, "= " gid) }
			{ print }
		'
) "$@"
