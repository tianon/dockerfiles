#!/usr/bin/env bash
set -Eeuo pipefail

# see http://stackoverflow.com/a/2705678/433558
sed_escape_lhs() {
	sed -e 's/[]\/$*.^|[]/\\&/g' <<<"$*"
}
sed_escape_rhs() {
	sed -e 's/[\/&]/\\&/g' <<<"$*"
}

# magic with environment variables
for cfg in \
	/etc/mfs/mfschunkserver.cfg \
	/etc/mfs/mfsmaster.cfg \
	/etc/mfs/mfsmetalogger.cfg \
; do
	base="$(basename "$cfg" '.cfg')" # "mfsmaster", etc
	base="${base^^}_" # "MFSMASTER_"
	eval 'envs=( "${!'"$base"'@}" )' # envs=( "${!MFSMASTER_@}" )
	for env in "${envs[@]}"; do
		var="${env#$base}" # "HDD_CONF_FILENAME"
		val="${!env}" # "/mnt/mfs/mfshdd.cfg"
		sedVar="$(sed_escape_lhs "$var")"
		sedVal="$(sed_escape_rhs "$val")"
		sed -ri -e 's/^([[:space:]]*#)?[[:space:]]*('"$sedVar"')[[:space:]]*=.*$/\2 = '"$sedVal"'/' "$cfg"
		if ! grep -qE "^$sedVar =" "$cfg"; then
			echo >&2 "warning: $var ($env) was not found in '$cfg' (so might be a typo!)"
			{ echo; echo "$var = $val"; } >> "$cfg"
		fi
	done
done

exec "$@"
