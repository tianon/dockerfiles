#!/bin/bash
set -e

if [ "$1" = 'exim' ]; then
	if [ -n "$GMAIL_USER" ] && [ -n "$GMAIL_PASSWORD" ]; then
		# see https://wiki.debian.org/GmailAndExim4
		set-exim4-update-conf \
			dc_eximconfig_configtype 'smarthost' \
			dc_smarthost 'smtp.gmail.com::587'
		echo "smtp.gmail.com:$GMAIL_USER:$GMAIL_PASSWORD" > /etc/exim4/passwd.client
	fi

	if [ "$(id -u)" = '0' ]; then
		mkdir -p /var/spool/exim4 /var/log/exim4 || :
		chown -R Debian-exim:Debian-exim /var/spool/exim4 /var/log/exim4 || :
	fi

	if [ "$$" = 1 ]; then
		set -- tini -- "$@"
	fi
fi

exec "$@"
