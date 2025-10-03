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
ENV RUNC_VERSION 1.3.2
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.3.2/runc.amd64'; sha256='e7a8e30bd6d248f494aae9163521ff4eb112a30602ac56ada0871e3531269c2d' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.3.2/runc.386'; sha256='71dbf6ac158f334de42d3249aeefb5d4a539e8bbea5173a739a09d6fc3b05435' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.3.2/runc.arm64'; sha256='06fbccb4528ecd490f3f333d6dcf22c876bd72a024813a0c0a46312121f4c5fd' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.3.2/runc.armhf'; sha256='7457f5dd7c76d3181597570cfde423971b92fd5761a08ec0502f2ee417856595' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.3.2/runc.ppc64le'; sha256='9373062bc547b5afe44fb0122a12aaa980763969d4b69dd17134a6a292838ce5' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.3.2/runc.riscv64'; sha256='7fc709fff5f10c2fb87b6090245b431ba214e167734baafc8a7aff02085497fa' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.3.2/runc.s390x'; sha256='bcca8662841d27e4189f14d9abbef3f07411e87347ca27e2a65a580bc26cb579' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.1.4
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-amd64.tar.gz'; sha256='316d510a0428276d931023f72c09fdff1a6ba81d6cc36f31805fea6a3c88f515' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-arm64.tar.gz'; sha256='846d13bc2bf1c01ae2f20d13beb9b3a1e50b52c86e955b4ac7d658f5847f2b0e' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-ppc64le.tar.gz'; sha256='d519e40e266f39cdd68f2c31e2e4e9b70eda09b96f3c3de343a7a3e11d49ad4c' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-riscv64.tar.gz'; sha256='2a6ce108639d5354a504146b82181d11634b8c7dc678dabb03d16d28a8c5725a' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-s390x.tar.gz'; sha256='be5b75203ab3ac5b6a9b5c0907315a9e4e1e2e0edd25505f0a783fb929b2cb87' ;; \
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
