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
ENV RUNC_VERSION 1.2.6
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.2.6/runc.amd64'; sha256='0774f49d1b1eebb5849e644db5e4dc6f2b06cee05f13b3d17d5d6ba62d6f2ebc' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.2.6/runc.386'; sha256='49e70b0532207ec9fa4bb3dc8c65051615a8eef4ee857834ee4a82b86be71448' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.2.6/runc.arm64'; sha256='12c612e2ebe6ca198de676ce75ed557e79fe6109032209bb8e25166c967fe170' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.2.6/runc.armhf'; sha256='87f159b09039edb41b2f2f930e37cfa7dc58183c9e5b767fdbd764846fe3c0ac' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.2.6/runc.ppc64le'; sha256='0d7fffba4f89920edd3246afd4f07b18a975d0d97193ffae418e8418c236c168' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.2.6/runc.riscv64'; sha256='1630d60195d7af7982df098a2d8dcda8de095ddcd66a354706919fc0177c4a7b' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.2.6/runc.s390x'; sha256='6c863bdef4f24b2476926ef3c48e34e5b384dc4035bb74ea8d0cded121820892' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.0.4
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.0.4/containerd-2.0.4-linux-amd64.tar.gz'; sha256='e1c64c5fd60ecd555e750744eaef150b6f78d7f750da5c08c52825aa6b791737' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.0.4/containerd-2.0.4-linux-arm64.tar.gz'; sha256='0fde98b24bb55363a54150732e0ac99a43bccf2a9711371bd5470f32790316f2' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.0.4/containerd-2.0.4-linux-ppc64le.tar.gz'; sha256='ca970d9a53ae504bc36197d6daa931338c387c83b6948b9f9bfdd1a75e25dcf6' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.0.4/containerd-2.0.4-linux-riscv64.tar.gz'; sha256='c607bfff00f7fad2f6bc552999959120d1a943d0b9ce594ca2b47f91eb7d3944' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.0.4/containerd-2.0.4-linux-s390x.tar.gz'; sha256='85f98603375fb1579af3b60f147a05a8a6104602bd6604cb7072fe543e83b30f' ;; \
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
