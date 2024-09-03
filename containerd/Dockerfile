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

# https://github.com/docker/docker/tree/master/hack/dind
ENV DIND_COMMIT 65cfcc28ab37cb75e1560e4b4738719c07c6618e
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	sh -n /usr/local/bin/dind; \
	chmod +x /usr/local/bin/dind

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.1.14
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.1.14/runc.amd64'; sha256='a83c0804ebc16826829e7925626c4793da89a9b225bbcc468f2b338ea9f8e8a8' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.1.14/runc.arm64'; sha256='050ee97c266bf7d31e1474568ffcbb2a3ff2208087aaa238c8bbe7e398414126' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.1.14/runc.armhf'; sha256='be02859fa1e020e4596b8b9cf920b6ec41b94da1cde916145448fcd356a2743c' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.1.14/runc.ppc64le'; sha256='31630474455c4208594623f1337a06556c7fe42d3983000ca800ad3bef6d8164' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.1.14/runc.riscv64'; sha256='71eb534cbb37354d5caca787c9de4aca0000d2b42950cbd24d2016ca174ae48d' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.1.14/runc.s390x'; sha256='364f2393bee8723bb5039ec5f41dbdb65f6800e6e5d70b10327431ed040f32a1' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 1.7.21
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-amd64.tar.gz'; sha256='3d1fcdfd0b141f4dc4916b7aee7f9a7773dc344baffc8954e1ca66b1adc5c120' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-arm64.tar.gz'; sha256='7b6b67d998eb86856d23df5d57269c054539072bbb27677975cf78269b2c5c10' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-ppc64le.tar.gz'; sha256='5ce0c1125e8d9ca04e2b524a2bac8b1eb97876c073023d5e083f7da64fcd8207' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-riscv64.tar.gz'; sha256='ca21e34f705c3722c637f6dd6ee839b81a0186349f17c7886566830bd6c4a722' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-s390x.tar.gz'; sha256='2f3332cb47d3d21400bf46c1518ee55be64483f0db2526f2ec64846b94e69ca1' ;; \
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
