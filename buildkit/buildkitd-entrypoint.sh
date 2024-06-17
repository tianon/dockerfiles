#!/usr/bin/env bash
set -Eeuo pipefail

if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	# https://github.com/moby/buildkit/blob/v0.14.0/frontend/gateway/gateway.go#L291
	# if we appear to be running as a frontend, let's run the frontend code
	if [ -n "${BUILDKIT_SESSION_ID:-}" ]; then
		set -- dockerfile-frontend "$@"
	else
		set -- buildkitd "$@"
	fi
fi

exec "$@"
