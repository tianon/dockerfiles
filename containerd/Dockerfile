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
ENV RUNC_VERSION 1.4.3
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.4.3/runc.amd64'; sha256='f6ae8efc0fa40079e1475e97cbe9d1bd3f106a28d6af78a11d9f1bd565515e60' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.4.3/runc.386'; sha256='d552b592e4c0382eee7eaab0dfd6707f33f218a26f6a8ab578298f8f7bb41d62' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.4.3/runc.arm64'; sha256='633301e2e32f8a5ad54031aab4901eb00308bec677dd15faa2751e8f9dab5ca4' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.4.3/runc.armhf'; sha256='7246fd0289494b29161afbdd49df44534e0ce4157e011407399c24922bdb2a9e' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.4.3/runc.ppc64le'; sha256='9a10f813733a5bdf740e9513a210d817bec08cab6939913a25362e5c5915fbdc' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.4.3/runc.riscv64'; sha256='187cf94df7043d4f385384a8fcc7eb163a33e3516464e41dec500f303f4a79d5' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.4.3/runc.s390x'; sha256='b6d50cf2aa51057a4c94e660b0a0512974c8a2a78a46874b07cf58c0c4f2a5da' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.3.1
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.3.1/containerd-2.3.1-linux-amd64.tar.gz'; sha256='628448bd973610c656c1cbea8e88b32fafd85b23cc1aa4a3372eb7198478c054' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.3.1/containerd-2.3.1-linux-arm64.tar.gz'; sha256='46a83603a850f3916ca7c942310daaf82ed17773a85b1d431e92d4a541e46d0d' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.3.1/containerd-2.3.1-linux-ppc64le.tar.gz'; sha256='cb5bcdb38c79fb78dc7b4e7c02d0c0e41b486446f646a49ed7e6c35c077d8d33' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.3.1/containerd-2.3.1-linux-riscv64.tar.gz'; sha256='07816d92bfe7588146657521d053a45d50aea38bedf14661a7c082e8ea323cd6' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.3.1/containerd-2.3.1-linux-s390x.tar.gz'; sha256='4e40915edad102ba29ab53d159e67b6a8bf4a1c96936550909a75c0f2e5beec8' ;; \
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
