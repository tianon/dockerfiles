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
ENV RUNC_VERSION 1.4.1
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.4.1/runc.amd64'; sha256='b6d50dad89a420cafcdc0eebf4bed132a45b161d5bc1ba4ddd8cc4422d24a983' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.4.1/runc.386'; sha256='3a225b7a0408885065e8f7eefc446a43f72c04bc3bb71c3e7336919f7e4689b1' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.4.1/runc.arm64'; sha256='80d5757c46152c35151621cf394ee08cec881716169d0fdd40f9ce124d3c85f5' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.4.1/runc.armhf'; sha256='7419c8ac2229a01098421400e5a3cb87c99d1211429863cd9a5560fe2321b32b' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.4.1/runc.ppc64le'; sha256='9758879188759989fd54fa287af3e51a78cf147309cd0336139685f026f531ed' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.4.1/runc.riscv64'; sha256='56e0c720007c54f4e2fb65e3428c2eb9e5742bc83645164a311af5aff37a0047' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.4.1/runc.s390x'; sha256='f390ad0adffad7601838b82d46697b56f7fceed0798caa4b3f2298274dbcab5b' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.2.2
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.2.2/containerd-2.2.2-linux-amd64.tar.gz'; sha256='2c08c99cbde73b3388c6d5da68e0bcaebc70c9174f2b14d785695e4401b3ede0' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.2.2/containerd-2.2.2-linux-arm64.tar.gz'; sha256='cb102473d6e353beb604178879d51cc456da0cdf368d9437d8d404ed01baf674' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.2.2/containerd-2.2.2-linux-ppc64le.tar.gz'; sha256='8f7a8190f2a635cd0e5580a131408a275ba277f7a04edffba4a4005960093987' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.2.2/containerd-2.2.2-linux-riscv64.tar.gz'; sha256='9a7879f370a57bfb6b42f54aa562bc5383a0768392bdaefd37ce6357c381c908' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.2.2/containerd-2.2.2-linux-s390x.tar.gz'; sha256='0d449ba63caae2779f4105248198860b99924c274ad968bb24b3654f17c3cf9e' ;; \
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
