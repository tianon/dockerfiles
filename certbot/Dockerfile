FROM python:3.8-alpine3.12

# Executable not found: can't find the executable for the dialog-like program
RUN apk add --no-cache dialog

ENV CERTBOT_VERSION 1.10.0

RUN set -ex; \
	\
	apk add --no-cache --virtual .build-deps \
		gcc \
		libffi-dev \
		musl-dev \
		openssl-dev \
	; \
	\
	pip install --no-cache-dir certbot==$CERTBOT_VERSION; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --recursive /usr/local \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)"; \
	apk add --virtual .certbot-rundeps $runDeps; \
	apk del .build-deps

#VOLUME /etc/letsencrypt
VOLUME /var/lib/letsencrypt
#VOLUME /var/log/letsencrypt

CMD ["certbot"]
