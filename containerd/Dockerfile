#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# runtime deps
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/docker/docker/tree/HEAD/hack/dind
ENV DIND_COMMIT 8d9e3502aba39127e4d12196dae16d306f76993d
# https://github.com/docker/docker/commit/8d9e3502aba39127e4d12196dae16d306f76993d -- 2025-03-26T12:11:44.000Z (@1742991104)
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://github.com/docker/docker/raw/${DIND_COMMIT}/hack/dind"; \
	sh -n /usr/local/bin/dind; \
	chmod +x /usr/local/bin/dind

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.3.0
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.3.0/runc.amd64'; sha256='028986516ab5646370edce981df2d8e8a8d12188deaf837142a02097000ae2f2' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.3.0/runc.386'; sha256='792de461a89f1161b11fc195a9bd98b595ea501c44e97638f62f3fcc9f97688e' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.3.0/runc.arm64'; sha256='85c5e4e4f72e442c8c17bac07527cd4f961ee48e4f2b71797f7533c94f4a52b9' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.3.0/runc.armhf'; sha256='1bf31a59d229193d6f6cdd7ef28cfc843fa156591d184e7d9f2adfd54e15fd03' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.3.0/runc.ppc64le'; sha256='156601012e6c473f2a5c7dbabbd08d8c56f151256433e6010bf4e5f6e569b5b6' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.3.0/runc.riscv64'; sha256='f98002406f1665654b6a531c2095dbe203ac1fdad549275551149c766aa32371' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.3.0/runc.s390x'; sha256='e68857c8bf5c06b8358cba5f979d66fde4654bb9d8c71a290abc7d0f3ef4b5b7' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.1.2
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.1.2/containerd-2.1.2-linux-amd64.tar.gz'; sha256='87c18b2686f38ee6f738492d04fc849f80567b7849d0710ee9d19fac3454adc4' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.1.2/containerd-2.1.2-linux-arm64.tar.gz'; sha256='57fa4005ed3bb648f4a2ff3ef2f9ce12b27ee1397225626e3165b9ef4af45530' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.1.2/containerd-2.1.2-linux-ppc64le.tar.gz'; sha256='9d8a02413050ae234eeef4152fb703b3d093b5809411f0e905f098554fc066d6' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.1.2/containerd-2.1.2-linux-riscv64.tar.gz'; sha256='9f4e72766b2c87653fe3d0f2de92eb10bf0776d0f41e83cab9a5e6219b5c4b26' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.1.2/containerd-2.1.2-linux-s390x.tar.gz'; sha256='344b4f3ad99adfaa5869a2ace10cb21d912ee648bc55fc568f5a873c933b80cd' ;; \
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
