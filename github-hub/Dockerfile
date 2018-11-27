FROM debian:stretch-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		git \
		openssh-client \
		vim-nox \
		wget \
	&& rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

WORKDIR /opt/hub
ENV PATH /opt/hub/bin:$PATH

# https://github.com/github/hub/releases
ENV GITHUB_HUB_VERSION 2.6.0

RUN set -ex; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		amd64) arch='amd64' ;; \
		arm64) arch='arm64' ;; \
		armhf) arch='arm' ;; \
		i386) arch='386' ;; \
		*) echo >&2 "error: unknown architecture '$dpkgArch'"; exit 1 ;; \
	esac; \
	wget -O hub.tgz "https://github.com/github/hub/releases/download/v${GITHUB_HUB_VERSION}/hub-linux-${arch}-${GITHUB_HUB_VERSION}.tgz"; \
	tar -xvf hub.tgz --strip-components 1 -C /usr/local; \
	rm -v hub.tgz; \
	\
	hub --version

CMD ["hub"]
