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
ENV RUNC_VERSION 1.5.2
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.5.2/runc.amd64'; sha256='599f6f94ff8c5057241eff0d54c3c74f95c34935b6457b33fe545defc61e9488' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.5.2/runc.386'; sha256='0016723f9d25dc45465b1c244d3457ca5764cb18a98f5d400f20182cd8fa3024' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.5.2/runc.arm64'; sha256='d10ecae898361832a059be2089bab92d158aec54661b18ed7346ed79628b46b0' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.5.2/runc.armhf'; sha256='14eb98c246a478140f23c25ad91033502e69b425692071bc5aa1f82ee609102d' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.5.2/runc.ppc64le'; sha256='82bc8abbc41fdc4e5ff2d3ee3c948830ace0c20ed033d8b2ec2f0e6f98fe75da' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.5.2/runc.riscv64'; sha256='f2e822e607f740736ad3924e2a3869ff4e8ab360103cec3c98af54700adbd112' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.5.2/runc.s390x'; sha256='c3ae5bc58d9a034d09fcd7ef49b350cd391ff7c6f966d3f6cc936344b6964ac6' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.4.1
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.4.1/containerd-2.4.1-linux-amd64.tar.gz'; sha256='d65eda6a188aac1006848d8060099be88ba9c4bcddbfd9a23a961194710d0dd4' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.4.1/containerd-2.4.1-linux-arm64.tar.gz'; sha256='67f9b0a81c7140aaf15fe69053e88175270fadd33aeaffc1b9017123c1f55cea' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.4.1/containerd-2.4.1-linux-ppc64le.tar.gz'; sha256='eab9c7fcdb966414f56aa8ea7db44fb46ad0c3e48716e60f18dce94b853f4eef' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.4.1/containerd-2.4.1-linux-riscv64.tar.gz'; sha256='2659d75d0bd65ae20daef9946399ae83dfe3a8f30c9de0ac361588dc162c4b61' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.4.1/containerd-2.4.1-linux-s390x.tar.gz'; sha256='1a0e9583e5da3ee206fffbf1f27eec10fb75be15353f8b3dd4d138603cd2c799' ;; \
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
