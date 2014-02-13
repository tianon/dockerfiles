#!/bin/bash
set -e

: ${MMS_SERVER:=https://mms.mongodb.com}
: ${MMS_CHECK_SSL_CERTS:=True}

if [ ! "$MMS_API_KEY" ]; then
	{
		echo 'error: MMS_API_KEY was not specified'
		echo 'try something like: docker run -e MMS_API_KEY=... ...'
		echo
		echo 'Other optional variables:'
		echo ' - MMS_SERVER = '"$MMS_SERVER"
		echo ' - MMS_CHECK_SSL_CERTS = '"$MMS_CHECK_SSL_CERTS"
	} >&2
	exit 1
fi

sed -i "s!@API_KEY@!$MMS_API_KEY!g" /mms-agent/settings.py
sed -i "s!@MMS_SERVER@!$MMS_SERVER!g" /mms-agent/settings.py
sed -i "s!@DEFAULT_REQUIRE_VALID_SERVER_CERTIFICATES@!$MMS_CHECK_SSL_CERTS!g" /mms-agent/settings.py

exec "$@"
