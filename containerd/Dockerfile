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
ENV RUNC_VERSION 1.1.10
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.amd64'; sha256='81f73a59be3d122ab484d7dfe9ddc81030f595cc59968f61c113a9a38a2c113a' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.arm64'; sha256='4830afd426bdeacbdf9cb8729524aa2ed51790b8c4b28786995925593708f1c8' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.armhf'; sha256='a78cf549da89cc39d2464a5433e3db50191b9fc69f0165cefb61bbfbf0ceb7de' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.ppc64le'; sha256='94a091c06c363e4af7be398dc31fa6e02576d5ecda6de1cbf3a08fe8662bf678' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.riscv64'; sha256='0fcff1af876effb69c670c335e44e0afa4c3523695e382dc8740301c8dc67160' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.s390x'; sha256='1940ef78f89a4ec2951ef9013b2572dd916888712d3e96ad29a928523a6d1104' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 1.7.10
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.10/containerd-1.7.10-linux-amd64.tar.gz'; sha256='eacb0296bff2ae5225a18492dcb32fb28ad4a1fe0a39ea9073367c7e43dc5838' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.10/containerd-1.7.10-linux-arm64.tar.gz'; sha256='0667b12a04a896a61cf508a4a77190c280f4a1fa35f38c8a4ba63f605b5ec375' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.10/containerd-1.7.10-linux-ppc64le.tar.gz'; sha256='15a5191bf7c555956a8565d8786399d51b13f2718d59b1a5b2bd380fc420bf8a' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.10/containerd-1.7.10-linux-riscv64.tar.gz'; sha256='7a07dea0417ebdead409dd2510f7ef867d3f435ff3fcae2f83eba1425d1a788a' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.10/containerd-1.7.10-linux-s390x.tar.gz'; sha256='c2e491c193affe707202e0b55fa9e49c6e4c0c9156d00cff5db192c5e051f192' ;; \
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
