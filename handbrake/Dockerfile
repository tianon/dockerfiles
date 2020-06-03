FROM ubuntu:focal

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends gnupg dirmngr; \
	rm -rf /var/lib/apt/lists/*; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys 43D3A9F60C58A7169778E6FB8771ADB0816950D8; \
	gpg --batch --export --armor 43D3A9F60C58A7169778E6FB8771ADB0816950D8 > /etc/apt/trusted.gpg.d/handbrake.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

# https://handbrake.fr/downloads.php
# https://launchpad.net/~stebbins/+archive/ubuntu/handbrake-releases
RUN set -eux; \
	suite="$(awk '$1 == "deb" { print $3; exit }' /etc/apt/sources.list)"; \
	echo "deb http://ppa.launchpad.net/stebbins/handbrake-releases/ubuntu $suite main" > /etc/apt/sources.list.d/handbrake.list

ENV HANDBRAKE_VERSION 1.3.2
ENV HANDBRAKE_PPA_VERSION 1:1.3.2-zhb-1ppa1~focal1

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"handbrake-cli=$HANDBRAKE_PPA_VERSION" \
		"handbrake-gtk=$HANDBRAKE_PPA_VERSION" \
	; \
	rm -rf /var/lib/apt/lists/*
