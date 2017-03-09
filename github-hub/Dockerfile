FROM debian:stretch-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		git \
		vim-nox \
		wget \
	&& rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

WORKDIR /opt/hub
ENV PATH /opt/hub/bin:$PATH

ENV GITHUB_HUB_VERSION 2.2.9

RUN set -ex; \
	\
	wget -O hub.tgz "https://github.com/github/hub/releases/download/v${GITHUB_HUB_VERSION}/hub-linux-amd64-${GITHUB_HUB_VERSION}.tgz"; \
	tar -xvf hub.tgz --strip-components 1 -C /usr/local; \
	rm -v hub.tgz; \
	\
	hub --version

CMD ["hub"]
