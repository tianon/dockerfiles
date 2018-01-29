#!/bin/bash
set -e

opts=(
	dc_local_interfaces '0.0.0.0 ; ::0'
	dc_other_hostnames ''
	dc_relay_nets '0.0.0.0/0'
)

if [ "$GMAIL_USER" -a "$GMAIL_PASSWORD" ]; then
	# see https://wiki.debian.org/GmailAndExim4
	opts+=(
		dc_eximconfig_configtype 'smarthost'
		dc_smarthost 'smtp.gmail.com::587'
	)
	echo "*.google.com:$GMAIL_USER:$GMAIL_PASSWORD" > /etc/exim4/passwd.client
else
	opts+=(
		dc_eximconfig_configtype 'internet'
	)
fi

set-exim4-update-conf "${opts[@]}"

if [ "$(id -u)" = '0' ]; then
	mkdir -p /var/spool/exim4 /var/log/exim4 || :
	chown -R Debian-exim:Debian-exim /var/spool/exim4 /var/log/exim4 || :
fi

exec "$@"
