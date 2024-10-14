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
ENV RUNC_VERSION 1.1.15
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.1.15/runc.amd64'; sha256='d218e1f8be4dcb1f288dea754faee342375a36f695eac5ab37fc8b7270a78763' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.1.15/runc.arm64'; sha256='c680f8c470ffb228944ca80e1a4dbb6768b3ad97057350852e128847f9dd10bc' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.1.15/runc.armhf'; sha256='4765ffa9ae1ccf1cbde5b984c6d61c61086062096a4f5446243aef445fbf1ae4' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.1.15/runc.ppc64le'; sha256='b4c8dbbd4973b1cc69fcade012db690e26e0b354d5fcdf04a12ffe972d5ab098' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.1.15/runc.riscv64'; sha256='c9a37148894268cf5679da7c0cdbe21095e3ec19f612620d7f0da23d304edca5' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.1.15/runc.s390x'; sha256='cbbc1c8ee26b090ce3f3e0eb1a4f06b940ec76c4eed29527c223fd5de8cbe673' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 1.7.23
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.23/containerd-1.7.23-linux-amd64.tar.gz'; sha256='8a0de43d9313aef2ebdccc0ffa49461a4a28139a2c0ef104c3c847f6f37c8119' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.23/containerd-1.7.23-linux-arm64.tar.gz'; sha256='6a66b5e63a5e88ff7eeb478ccaca9083d44e51e1d7261ae183fe5951a6226ccd' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.23/containerd-1.7.23-linux-ppc64le.tar.gz'; sha256='00dd8a1145d7392ffe1e2b74da147b896e4387afb5e73ed6e5cd3744add32826' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.23/containerd-1.7.23-linux-riscv64.tar.gz'; sha256='9a5b2c3d4d78491f52e0b43f5acd40a92eda4e0d453c12ad6deb0767c805e451' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.23/containerd-1.7.23-linux-s390x.tar.gz'; sha256='08844879d9ce88a3659dbc8a9882251c91717e94efe65759c4533fc19a315278' ;; \
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
