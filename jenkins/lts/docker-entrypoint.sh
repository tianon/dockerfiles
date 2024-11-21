#!/usr/bin/env bash
set -Eeuo pipefail

# TODO more argument detection (hyphens, etc)
if [ "$#" -eq 0 ]; then
	set -- jenkins "$@"
fi

if [ "$1" = 'jenkins' ] || [ "$1" = 'java' ]; then
	set -- tini -- "$@"

	uid="$(id -u)"
	if [ "$uid" = 0 ]; then
		chown -R jenkins "$JENKINS_HOME"
		set -- gosu jenkins "$@"
	fi
fi

exec "$@"
