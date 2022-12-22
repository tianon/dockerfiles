#!/usr/bin/env bash
set -Eeuo pipefail

if [ "$#" -eq 0 ] || [ "$1" = 'prometheus' ] || [[ "$1" = '-'* ]]; then
	if [ "${1:-}" = 'prometheus' ]; then
		shift
	fi
	args=(
		prometheus
		'--config.file=/opt/prometheus/prometheus.yml'
		'--storage.tsdb.path=/opt/prometheus/data'
		'--web.console.libraries=/opt/prometheus/console_libraries'
		'--web.console.templates=/opt/prometheus/consoles'
	)
	set -- "${args[@]}" "$@"
fi

exec "$@"
