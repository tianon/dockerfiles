FROM debian:stretch-slim

# grab tini for signal processing and zombie killing
ENV TINI_VERSION v0.13.0
RUN set -x \
	\
	&& fetchDeps=' \
		gnupg dirmngr \
		wget ca-certificates \
	' \
	&& apt-get update && apt-get install -y --no-install-recommends $fetchDeps && rm -rf /var/lib/apt/lists/* \
	\
	&& wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini-amd64" \
	&& wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini-amd64.asc" \
	\
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
	&& gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
	&& gpgconf --kill all \
	&& rm -r "$GNUPGHOME" /usr/local/bin/tini.asc \
	\
	&& chmod +x /usr/local/bin/tini \
	&& tini -h \
	\
	&& apt-get purge --auto-remove -y $fetchDeps

RUN apt-get update && apt-get install -y apt-cacher-ng && rm -rf /var/lib/apt/lists/*

RUN { \
		echo 'ForeGround: 1'; \
		echo 'Port: 80'; \
	} > /etc/apt-cacher-ng/docker.conf

RUN ln -sf /dev/stdout /var/log/apt-cacher-ng/apt-cacher.out \
	&& ln -sf /dev/stderr /var/log/apt-cacher-ng/apt-cacher.err

RUN echo 'http://deb.debian.org/debian/' > /etc/apt-cacher-ng/backends_debian
RUN echo 'http://archive.ubuntu.com/ubuntu/' > /etc/apt-cacher-ng/backends_ubuntu

EXPOSE 80
CMD ["tini", "--", "apt-cacher-ng", "-c", "/etc/apt-cacher-ng"]
