FROM debian:stretch-slim

# https://wiki.winehq.org/Debian

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends apt-transport-https ca-certificates; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get install -y --no-install-recommends gnupg2 dirmngr; \
	rm -rf /var/lib/apt/lists/*; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys D43F640145369C51D786DDEA76F1A20FF987672F; \
	gpg --batch --export --armor D43F640145369C51D786DDEA76F1A20FF987672F > /etc/apt/trusted.gpg.d/winehq.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-key list | grep 'WineHQ'; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	dpkg --add-architecture i386; \
	suite="$(awk '$1 == "deb" { print $3; exit }' /etc/apt/sources.list)"; \
	echo "deb https://dl.winehq.org/wine-builds/debian $suite main" > /etc/apt/sources.list.d/winehq.list

ENV WINE_VERSION 4.0.3

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"winehq-stable=$WINE_VERSION*" \
	; \
	rm -rf /var/lib/apt/lists/*
