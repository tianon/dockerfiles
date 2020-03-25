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

# backwards compatibility
for cfg in */mfshdd.cfg; do
	[ -f "$cfg" ] || continue
	dir="$(dirname "$cfg")"
	new="$dir-mfshdd.cfg"
	if [ ! -f "$new" ]; then
		mv -vT "$cfg" "$new"
	fi
done

# auto-detect and prepare new chunkservers
for chunks in */chunks/; do
	chunks="${chunks%/}"
	[ -d "$chunks" ] || continue
	dir="$(dirname "$chunks")"
	cfg="$dir-mfshdd.cfg"
	if [ ! -s "$cfg" ]; then
		readlink -f "$chunks" >> "$cfg"
	fi
done

port='9422'
for cfg in *-mfshdd.cfg; do
	[ -f "$cfg" ] || continue

	base="${cfg%-mfshdd.cfg}"
	name="$(basename "$base")"
	dir="$(dirname "$base")"

	var="$dir/.var-lib-mfs-$name"
	if [ ! -d "$var" ]; then
		if [ -d "$dir/$name/var-lib-mfs" ]; then
			# backwards compatibility
			mv -vT "$dir/$name/var-lib-mfs" "$var"
		else
			# pre-seed our new state directory with the standard "empty" contents
			cp -aT /var/lib/mfs "$var"
			chmod 755 "$var" || :
		fi
	fi

	copy_etc "$temp/$name"

	sed -r "s!/etc/mfs!$temp/$name!g" /usr/local/bin/docker-entrypoint.sh > "$temp/$name/entrypoint.sh"
	chmod +x "$temp/$name/entrypoint.sh"

	cfg="$(readlink -f "$cfg")"
	var="$(readlink -f "$var")"
	MFSCHUNKSERVER_CSSERV_LISTEN_PORT="$port" \
		MFSCHUNKSERVER_SYSLOG_IDENT="$name" \
		MFSCHUNKSERVER_HDD_CONF_FILENAME="$cfg" \
		MFSCHUNKSERVER_DATA_PATH="$var" \
		"$temp/$name/entrypoint.sh" \
		mfschunkserver -func "$temp/$name/mfschunkserver.cfg" &
	pid="$!"
	pids["$name"]="$pid"

	(( port++ )) || :
	all_still_up || end_session 1
done

while any_still_up; do
	all_still_up || end_session 1
	sleep 5
done
