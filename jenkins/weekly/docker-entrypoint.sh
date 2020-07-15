#!/bin/bash
set -e

if [ "$1" = 'java' ]; then
	chown -R jenkins "$JENKINS_HOME"

	set -- gosu jenkins tini -- "$@"
fi

exec "$@"
