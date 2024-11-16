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
ENV RUNC_VERSION 1.2.2
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.amd64'; sha256='a34f5ab4fc1df1f456293c3d797a76f2d41cf3cd970bb49fc53ba94bbc8a5cf6' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.386'; sha256='7d05edbb10405f3fa77d8e6b3646cab4ca07a67c21110fcdc05d2e33224bf253' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.arm64'; sha256='bfd3e6c58bd6060eaa725520c31cbc8f6386ac7606e65bfa7fe9084100aa1789' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.armhf'; sha256='78b8eb427e4b55431edc1d73772889f0905b7ae9f1273839fe9478edc1a99949' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.ppc64le'; sha256='9af46fe0bdc654c72593a937806ca034ffbbf4f62f25c1de7a40b5b0f4374de7' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.riscv64'; sha256='cc169ba3fe80981759034c5ebcb20534d90c4d3e8e6825950bc2c192f800bd0b' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.2.2/runc.s390x'; sha256='33fe3bab8d12a43f0499fc018abbac2536e61c0c30bc9e962df363549ae58b34' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.0.0
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.0.0/containerd-2.0.0-linux-amd64.tar.gz'; sha256='6f8da716941f7e89315cefaa6e5a8f1ff10b323ff46611313c455df7ab1ebee1' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.0.0/containerd-2.0.0-linux-arm64.tar.gz'; sha256='2a00b1553f38aa9e716d61316b661961c2fbfbb7aad7bd73b377be5725ecc0f1' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.0.0/containerd-2.0.0-linux-ppc64le.tar.gz'; sha256='2e7f4b15ac85c22c1ced102bbb424124078248f0af3183425ff335a998079809' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.0.0/containerd-2.0.0-linux-riscv64.tar.gz'; sha256='d54d8f44151706fded02c2c657d30cb8360bfa7d66d715ea522452367fb2c376' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.0.0/containerd-2.0.0-linux-s390x.tar.gz'; sha256='06015a6a238b97f2ce4cc2f6a9d8f711af2784fe197660b2e7eef4ea3b5328de' ;; \
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
