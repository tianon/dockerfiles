#!/bin/bash
set -e

: ${MMS_SERVER:=https://mms.mongodb.com}

if [ ! "$MMS_API_KEY" ]; then
	{
		echo 'error: MMS_API_KEY was not specified'
		echo 'try something like: docker run -e MMS_API_KEY=... ...'
		echo '(see https://mms.mongodb.com/settings/monitoring-agent for your mmsApiKey)'
		echo
		echo 'Other optional variables:'
		echo ' - MMS_SERVER='"$MMS_SERVER"
	} >&2
	exit 1
fi

# "sed -i" can't operate on the file directly, and it tries to make a copy in the same directory, which our user can't do
config_tmp="$(mktemp)"
cat /etc/mongodb-mms/monitoring-agent.config > "$config_tmp"

set_config() {
	key="$1"
	value="$2"
	sed_escaped_value="$(echo "$value" | sed 's/[\/&]/\\&/g')"
	sed -ri "s/^($key)[ ]*=.*$/\1 = $sed_escaped_value/" "$config_tmp"
}

set_config mmsApiKey "$MMS_API_KEY"
set_config mmsBaseUrl "$MMS_SERVER"

cat "$config_tmp" > /etc/mongodb-mms/monitoring-agent.config
rm "$config_tmp"

exec "$@"
