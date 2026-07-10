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
ENV RUNC_VERSION 1.5.0
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.5.0/runc.amd64'; sha256='0363e69bebd3a027d1239364ab9b4f4873f6bc4e7a7878e94b4ea59f08551297' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.5.0/runc.386'; sha256='004c84cba333247cd15a5ea148b1c2c778f644e2836acf0c26196c56a2de4e38' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.5.0/runc.arm64'; sha256='1f6d8c553add066a6aaf838d3172d4c5ed3c6b065b6f7eed2f4a4aa4af261e59' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.5.0/runc.armhf'; sha256='283e85880170bd92eb430b2e458aa7f57b85e613a8ae69572d6d13d0ad34dee8' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.5.0/runc.ppc64le'; sha256='e20482d620d1f4b80843251d16b407ec06e1d76dd592e6c7892541e9174a20b7' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.5.0/runc.riscv64'; sha256='00717739ec2cbdb0883fe6f4eab0aa39bdc6d55eeeb5c8462d2a105112b8cca8' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.5.0/runc.s390x'; sha256='46085ecf785f8860121735986a37880ebd8de07202ac29fca095722f475517df' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.3.3
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.3.3/containerd-2.3.3-linux-amd64.tar.gz'; sha256='ebf6e710056312628eaf6fb4a1c32f0a4ae5f812568321be4029389d66fc7c7c' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.3.3/containerd-2.3.3-linux-arm64.tar.gz'; sha256='9cc708f13c31588a2fbdbd13553d963356e990d50e9b95a2d6120f4ff2067910' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.3.3/containerd-2.3.3-linux-ppc64le.tar.gz'; sha256='248605bbedeec0d5d5ef5ce264a83cd1958b79b9c70f5c0bf3a3586596fa7dd7' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.3.3/containerd-2.3.3-linux-riscv64.tar.gz'; sha256='085a8a8a4303317f886dcc0a876677364386792563ad927c12cab17d7ac7e1e0' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.3.3/containerd-2.3.3-linux-s390x.tar.gz'; sha256='e1aa501839cdb9653e6fc596c668548f4697711535f9b2348965c71920e8f5d2' ;; \
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
