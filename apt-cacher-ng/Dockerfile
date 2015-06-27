FROM debian:sid

ENV TINI_VERSION 0.5.0
RUN set -x \
	&& apt-get update && apt-get install -y ca-certificates curl --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& curl -fSL "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini" -o /usr/local/bin/tini \
	&& chmod +x /usr/local/bin/tini \
	&& tini -h \
	&& apt-get purge --auto-remove -y ca-certificates curl

RUN apt-get update && apt-get install -y apt-cacher-ng && rm -rf /var/lib/apt/lists/*

RUN { \
		echo 'ForeGround: 1'; \
		echo 'Port: 80'; \
	} > /etc/apt-cacher-ng/docker.conf

RUN ln -sf /dev/stdout /var/log/apt-cacher-ng/apt-cacher.out \
	&& ln -sf /dev/stderr /var/log/apt-cacher-ng/apt-cacher.err

RUN echo 'http://httpredir.debian.org/debian/' > /etc/apt-cacher-ng/backends_debian
RUN echo 'http://archive.ubuntu.com/ubuntu/' > /etc/apt-cacher-ng/backends_ubuntu

EXPOSE 80
CMD ["tini", "--", "apt-cacher-ng", "-c", "/etc/apt-cacher-ng"]
