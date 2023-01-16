#!/usr/bin/env bash
set -Eeuo pipefail

if [ "$#" -eq 0 ] || [ "$1" = 'alertmanager' ] || [[ "$1" = '-'* ]]; then
	if [ "${1:-}" = 'alertmanager' ]; then
		shift
	fi
	args=(
		alertmanager
		# these already match the defaults if we set WORKDIR ("alertmanager.yml" and "data/" respectively)
		#'--config.file=/opt/alertmanager/alertmanager.yml'
		#'--storage.path=/opt/alertmanager/data'
	)
	set -- "${args[@]}" "$@"
fi

exec "$@"
