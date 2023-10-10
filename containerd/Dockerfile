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
ENV DIND_COMMIT d58df1fc6c866447ce2cd129af10e5b507705624
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	sh -n /usr/local/bin/dind; \
	chmod +x /usr/local/bin/dind

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.1.9
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.1.9/runc.amd64'; sha256='b9bfdd4cb27cddbb6172a442df165a80bfc0538a676fbca1a6a6c8f4c6933b43' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.1.9/runc.arm64'; sha256='b43e9f561e85906f469eef5a7b7992fc586f750f44a0e011da4467e7008c33a0' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.1.9/runc.armhf'; sha256='3c33909a3e2b40d879a1c07b89dc18c7dc727de61a6c381173e8c5c46b200c3d' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.1.9/runc.ppc64le'; sha256='065cf4f84b5acc0acdb017af2955743dfb5f5e1f49a493eea3e8206f33bf6fe6' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.1.9/runc.riscv64'; sha256='177a64486b8ce372938692f44e4aa6a6d9d3476a1f77b152142f02cf881a4817' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.1.9/runc.s390x'; sha256='363b317d44a44591205439e29f70f94f01eb51e58047b092b03b1cd2cdad533a' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 1.7.7
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.7/containerd-1.7.7-linux-amd64.tar.gz'; sha256='371de359d6102c51f6ee2361d08297948d134ce7379e01cb965ceeffa4365fba' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.7/containerd-1.7.7-linux-arm64.tar.gz'; sha256='0a104f487193665d2681fcb5ed83f2baa5f97849fe2661188da835c9d4eaf9e3' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.7/containerd-1.7.7-linux-ppc64le.tar.gz'; sha256='0335e7447ed84757489337686a709e95ffa379a8780f238725abb10facaeaa7f' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.7/containerd-1.7.7-linux-riscv64.tar.gz'; sha256='a48fe8c1aa84a0ebd634ca0d0672d63a0927f4cee24588f09ab79fa4e590d454' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.7/containerd-1.7.7-linux-s390x.tar.gz'; sha256='b06702c79a590028d09e428a6b80130a5222f873a784b3f775d0c1d65299101d' ;; \
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
