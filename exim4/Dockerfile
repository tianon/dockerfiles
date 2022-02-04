FROM debian:buster-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y \
		exim4-daemon-light \
		tini \
	; \
	rm -rf /var/lib/apt/lists/*; \
	ln -svfT /etc/hostname /etc/mailname

# https://blog.dhampir.no/content/exim4-line-length-in-debian-stretch-mail-delivery-failed-returning-message-to-sender
# https://serverfault.com/a/881197
# https://bugs.debian.org/828801
RUN echo "IGNORE_SMTP_LINE_LENGTH_LIMIT='true'" >> /etc/exim4/exim4.conf.localmacros

RUN set -eux; \
	mkdir -p /var/spool/exim4 /var/log/exim4; \
	chown -R Debian-exim:Debian-exim /var/spool/exim4 /var/log/exim4
VOLUME ["/var/spool/exim4", "/var/log/exim4"]

COPY set-exim4-update-conf docker-entrypoint.sh /usr/local/bin/
RUN set -eux; \
	set-exim4-update-conf \
		dc_eximconfig_configtype 'internet' \
		dc_hide_mailname 'true' \
		dc_local_interfaces '0.0.0.0 ; ::0' \
		dc_other_hostnames '' \
		dc_relay_nets '0.0.0.0/0' \
	;

EXPOSE 25
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["exim", "-bd", "-v"]
