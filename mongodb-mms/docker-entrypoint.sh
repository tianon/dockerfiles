#!/bin/bash
set -e

: ${MMS_SERVER:=https://mms.mongodb.com}
: ${MMS_MUNIN:=true}
: ${MMS_CHECK_SSL_CERTS:=true}

if [ ! "$MMS_API_KEY" ]; then
	{
		echo 'error: MMS_API_KEY was not specified'
		echo 'try something like: docker run -e MMS_API_KEY=... ...'
		echo '(see https://mms.mongodb.com/settings/monitoring-agent for your mmsApiKey)'
		echo
		echo 'Other optional variables:'
		echo ' - MMS_SERVER='"$MMS_SERVER"
		echo ' - MMS_MUNIN='"$MMS_MUNIN"
		echo ' - MMS_CHECK_SSL_CERTS='"$MMS_CHECK_SSL_CERTS"
	} >&2
	exit 1
fi

set_config() {
	key="$1"
	value="$2"
	sed_escaped_value="$(echo "$value" | sed 's/[\/&]/\\&/g')"
	sed -ri "s/^($key)[ ]*=.*$/\1 = $sed_escaped_value/" /etc/mongodb-mms/monitoring-agent.config
}

set_config mmsApiKey "$MMS_API_KEY"
set_config mmsBaseUrl "$MMS_SERVER"
set_config enableMunin "$MMS_MUNIN"
set_config sslRequireValidServerCertificates "$MMS_CHECK_SSL_CERTS"

exec "$@"
