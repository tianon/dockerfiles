#!/usr/bin/env bash
set -Eeuo pipefail

chunkservers="${MFS_CHUNKSERVERS:?set MFS_CHUNKSERVERS to the base directory of all chunkservers}"
cd "$chunkservers"

temp="$(mktemp -d)"
trap "$(printf 'rm -rf %q' "$temp")" EXIT

copy_etc() {
	local dir="$1"; shift
	cp -aT /etc/mfs "$dir"
	find "$dir" -type f -exec sed -ri "s!/etc/mfs!$dir!g" '{}' +
}

declare -A pids=()

all_still_up() {
	for pid in "${pids[@]}"; do
		if [ ! -d "/proc/$pid" ]; then
			return 1
		fi
	done
	return 0
}
any_still_up() {
	for pid in "${pids[@]}"; do
		if [ -d "/proc/$pid" ]; then
			return 0
		fi
	done
	return 1
}
end_session() {
	while any_still_up; do
		kill "${pids[@]}"
		sleep 1
		# TODO timeout?
	done
	exit "$@"
}
hup_all() {
	if any_still_up; then
		kill -HUP "${pids[@]}"
	fi
}
trap 'end_session 0' ABRT ALRM INT KILL PIPE QUIT STOP TERM USR1 USR2
trap 'end_session 1' ERR
trap 'hup_all' HUP

port='9422'

for dir in */; do
	dir="${dir%/}"
	name="$(basename "$dir")"
	dir="$(cd "$dir" && pwd -P)"
	if [ ! -s "$dir/mfshdd.cfg" ] && [ -d "$dir/chunks" ]; then
		echo "$dir/chunks" >> "$dir/mfshdd.cfg"
	fi
	if [ ! -s "$dir/mfshdd.cfg" ]; then
		echo >&2
		echo >&2 "error: $dir missing mfshdd.cfg (or chunks directory); is it mounted properly?"
		echo >&2
		end_session 1
	fi
	if [ ! -d "$dir/var-lib-mfs" ]; then
		cp -aT /var/lib/mfs "$dir/var-lib-mfs"
	fi
	copy_etc "$temp/$name"
	sed -r "s!/etc/mfs!$temp/$name!g" /usr/local/bin/docker-entrypoint.sh > "$temp/$name/entrypoint.sh"
	chmod +x "$temp/$name/entrypoint.sh"
	MFSCHUNKSERVER_CSSERV_LISTEN_PORT="$port" \
		MFSCHUNKSERVER_SYSLOG_IDENT="$name" \
		MFSCHUNKSERVER_HDD_CONF_FILENAME="$dir/mfshdd.cfg" \
		MFSCHUNKSERVER_DATA_PATH="$dir/var-lib-mfs" \
		"$temp/$name/entrypoint.sh" \
		mfschunkserver -func "$temp/$name/mfschunkserver.cfg" &
	pid="$!"
	pids[$name]="$pid"
	(( port++ )) || :
	all_still_up || end_session 1
done

while any_still_up; do
	all_still_up || end_session 1
	sleep 5
done
