#!/bin/bash
set -Eeuo pipefail

if [ "$1" = 'exim' ]; then
	if [ -n "${GMAIL_USER:-}" ] && [ -n "${GMAIL_PASSWORD:-}" ]; then
		# see https://wiki.debian.org/GmailAndExim4
		export EXIM4_SMARTHOST='smtp.gmail.com::587' \
			EXIM4_SMARTHOST_USER="$GMAIL_USER" \
			EXIM4_SMARTHOST_PASSWORD="$GMAIL_PASSWORD"
	fi
	unset GMAIL_USER GMAIL_PASSWORD # scrub env of creds

	if [ -n "${EXIM4_SMARTHOST:-}" ]; then
		set-exim4-update-conf \
			dc_eximconfig_configtype 'smarthost' \
			dc_smarthost "$EXIM4_SMARTHOST"
		if [ -n "${EXIM4_SMARTHOST_USER:-}" ] && [ -n "${EXIM4_SMARTHOST_PASSWORD:-}" ]; then
			echo "*:$EXIM4_SMARTHOST_USER:$EXIM4_SMARTHOST_PASSWORD" > /etc/exim4/passwd.client
		fi
	fi
	unset EXIM4_SMARTHOST EXIM4_SMARTHOST_USER EXIM4_SMARTHOST_PASSWORD # scrub env of creds

	if [ "$(id -u)" = '0' ]; then
		mkdir -p /var/spool/exim4 /var/log/exim4 || :
		chown -R Debian-exim:Debian-exim /var/spool/exim4 /var/log/exim4 || :
	fi

	if [ "$$" = 1 ]; then
		set -- tini -- "$@"
	fi
fi

exec "$@"
