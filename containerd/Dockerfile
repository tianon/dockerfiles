#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# runtime deps
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	; \
	apt-get dist-clean

# https://github.com/docker/docker/tree/HEAD/hack/dind
ENV DIND_COMMIT 8d9e3502aba39127e4d12196dae16d306f76993d
# https://github.com/docker/docker/commit/8d9e3502aba39127e4d12196dae16d306f76993d -- 2025-03-26T12:11:44.000Z (@1742991104)
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://github.com/docker/docker/raw/${DIND_COMMIT}/hack/dind"; \
	sh -n /usr/local/bin/dind; \
	chmod +x /usr/local/bin/dind

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.4.0
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.4.0/runc.amd64'; sha256='c5d4995c5aec204d7e1827d9d9a6b45042602736f7f415f484252e576dcdac28' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.4.0/runc.386'; sha256='3eeb1aef65853cd067edbd9c2ada439b70e0779283f3a7dfec17dde66db2a377' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.4.0/runc.arm64'; sha256='2adbeed4c751d6f2201c642ed06269ff4370fcc4165abd3f323e19c653716c31' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.4.0/runc.armhf'; sha256='faba2cd2ec9b28f1865a4efef9d57f2cab1736e7cd024bc74adea71cfa002448' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.4.0/runc.ppc64le'; sha256='9effd22d207c80ceab4816ce1736356c6b87ddf687ae1b5d9310523a7da92786' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.4.0/runc.riscv64'; sha256='cc853273e5be735bf05a0eb9aa6957ee66f60f41b10295228464a03d15ea4762' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.4.0/runc.s390x'; sha256='742e995f7b2cf054fbce5a72688ebe1c9a6fed32fa32ff2dc29acd7863fd1327' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.2.1
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.2.1/containerd-2.2.1-linux-amd64.tar.gz'; sha256='f5d8e90ecb6c1c7e33ecddf8cc268a93b9e5b54e0e850320d765511d76624f41' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.2.1/containerd-2.2.1-linux-arm64.tar.gz'; sha256='dac15a0d412a24be8bfe6a40cec8f51829062725169f1e72ac7d120a891ef5b6' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.2.1/containerd-2.2.1-linux-ppc64le.tar.gz'; sha256='3de0f215ea649952a9e99040cb3888d8059bd3d35b04edbe6afb916c763f9ea7' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.2.1/containerd-2.2.1-linux-riscv64.tar.gz'; sha256='0516aae9f1e615b7eb590a495b8a262e793e5afa0aaa754b6a6cb904290f0b5e' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.2.1/containerd-2.2.1-linux-s390x.tar.gz'; sha256='3fa156b2cbaf4d1e09b18e98ba000acb7c52b6f0ddb5103b8fb1a201ba9ac376' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
	wget -O containerd.tar.gz "$url" --progress=dot:giga; \
	echo "$sha256 *containerd.tar.gz" | sha256sum --strict --check -; \
	tar -xvf containerd.tar.gz -C /usr/local/; \
	rm containerd.tar.gz; \
	containerd --version

RUN set -eux; \
	mkdir -p /run/containerd /var/lib/containerd; \
	chmod 1777 /run/containerd /var/lib/containerd

VOLUME /var/lib/containerd

# add an entrypoint that does clever things if the container is run as non-root (cannot run containers, but content/image stores should work fine)
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["containerd"]

# the entrypoint will try to automatically determine intent based on uid/gid (and include the "dind" wrapper automatically)
# if it does not, use "docker run ... dind containerd" if you want to run real containers (with "--privileged")
