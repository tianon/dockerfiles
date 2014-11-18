FROM debian:sid

RUN apt-get update && apt-get install -y exim4-daemon-light

COPY set-exim4-update-conf /usr/local/bin/

RUN set-exim4-update-conf \
		dc_eximconfig_configtype internet \
		dc_other_hostnames '' \
		dc_local_interfaces '0.0.0.0 ; ::0'

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 25
CMD ["exim", "-bd", "-v"]
