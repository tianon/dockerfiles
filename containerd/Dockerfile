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
ENV CONTAINERD_VERSION 1.7.11
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.11/containerd-1.7.11-linux-amd64.tar.gz'; sha256='d66161d54546fad502fd50a13fcb79efff033fcd895adc9c44762680dcde4e69' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.11/containerd-1.7.11-linux-arm64.tar.gz'; sha256='5eae27cce38a14be5390d4035127aa11416bc5ae592a9ff25b11870872ce1159' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.11/containerd-1.7.11-linux-ppc64le.tar.gz'; sha256='6f91c5dabdccd1fc75aae8687381bb185b9eb4200beb29d0993dea8175f5fa61' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.11/containerd-1.7.11-linux-riscv64.tar.gz'; sha256='b0881c15bb4fd4b4e9bae3228867083a53a288fc0c0fb24c348cd32f2dce1327' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.11/containerd-1.7.11-linux-s390x.tar.gz'; sha256='ec85bb227e67854b429b9c7149b69faad08fe57ea27106188556e3b57118963d' ;; \
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
