#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

# runtime deps
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/docker/docker/tree/master/hack/dind
ENV DIND_COMMIT 65cfcc28ab37cb75e1560e4b4738719c07c6618e
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	sh -n /usr/local/bin/dind; \
	chmod +x /usr/local/bin/dind

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.1.11
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.1.11/runc.amd64'; sha256='77ae134de014613c44d25e6310a57a219a7a91155cd47d069a0f22a2cad5caea' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.1.11/runc.arm64'; sha256='9f1ee53f06b78cc4a115ca6ae4eec10567999539ce828a22c5351edba043ed12' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.1.11/runc.armhf'; sha256='8dd7e3e91762729b044c52ff562e56220f700548c8154fbadd1462302016adbc' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.1.11/runc.ppc64le'; sha256='e3d1da41f97db1bb7e9a8d96c9092747c14ee53bc9f160048828e63f3a2d0896' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.1.11/runc.riscv64'; sha256='202f67a2b2e540c9dc537fe1bd9f83cb521e3e8019f969ee0b10990c631e72ed' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.1.11/runc.s390x'; sha256='af2387aab26bc862b121515dde0b928a0d7933a140b2c574b8801edc595a963a' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 1.7.12
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.12/containerd-1.7.12-linux-amd64.tar.gz'; sha256='6a24d8b996533fa1b0d7348fe9813a78cd01fa16cff865a961ad0d556f5cd665' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.12/containerd-1.7.12-linux-arm64.tar.gz'; sha256='8a1b35a521d071a8828f63fe007a51e5b7ac863a1195f5dee32543b1a9d5f2b6' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.12/containerd-1.7.12-linux-ppc64le.tar.gz'; sha256='80f16891b387d86712026234de7d4d0365a38106dbe5e51b65b1200b24822721' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.12/containerd-1.7.12-linux-riscv64.tar.gz'; sha256='fdea70811a69ac0f1c5ade7e1948f655623c8f944cf90f453039e3fe8bff229f' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.12/containerd-1.7.12-linux-s390x.tar.gz'; sha256='dc4a7c3afaf08eeb3186b894faba6dccbbbe92cc58b649a4944e5f7b4ff8b25e' ;; \
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

# use "docker run ... dind containerd" if you want to run real containers (with "--privileged")
# see also Dockerfile.c8dind (or "tianon/containerd:c8dind")
