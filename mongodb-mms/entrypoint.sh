#!/bin/bash
set -e

if [ ! "$MMS_API_KEY" ] || [ ! "$MMS_SECRET_KEY" ]; then
	echo >&2 'one of MMS_API_KEY and MMS_SECRET_KEY was not specified'
	echo >&2 'try something like: docker run -e MMS_API_KEY=... -e MMS_SECRET_KEY=... ...'
	exit 1
fi

sed -i "s/@API_KEY@/$MMS_API_KEY/g" /mms-agent/settings.py
sed -i "s/@SECRET_KEY@/$MMS_SECRET_KEY/g" /mms-agent/settings.py

exec "$@"
