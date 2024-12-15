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
ENV DIND_COMMIT 65cfcc28ab37cb75e1560e4b4738719c07c6618e
# https://github.com/docker/docker/commit/65cfcc28ab37cb75e1560e4b4738719c07c6618e -- 2023-11-27T14:48:51.000+01:00 (@1701092931)
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://github.com/docker/docker/raw/${DIND_COMMIT}/hack/dind"; \
	sh -n /usr/local/bin/dind; \
	chmod +x /usr/local/bin/dind

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.2.3
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.2.3/runc.amd64'; sha256='e6e8c8049b1910fce58fa68c057aaa5f42cee2a73834df5e59e5da7612d2739d' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.2.3/runc.386'; sha256='038776ca70d107e8009c780b32f57129282bb6104ed83818ff5f6bbd0b15abd9' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.2.3/runc.arm64'; sha256='4ef19ab21ce1ae5a01e1d3fa5b005e45cdf59f5d3ab32541c9e262cb2b2d3451' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.2.3/runc.armhf'; sha256='2787d194b77d7823400c2200c2f4a4b3b39ab9bfeb11808188414ea7e32f7782' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.2.3/runc.ppc64le'; sha256='6d1b771096000a14faae660465faf9626a76afe994cbe60581ec4eac1718f12d' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.2.3/runc.riscv64'; sha256='8abe88e163f706848d0dae9202e26bbbb647f0f3b15135a4c11929df0a9ea9c8' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.2.3/runc.s390x'; sha256='5e0762f013c8c6f2e09eb2ccc8cb9e0210446e0757f40d03e633fe7a3d31da1e' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.0.1
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.0.1/containerd-2.0.1-linux-amd64.tar.gz'; sha256='85061a5ce1b306292d5a64f85d5cd3aff93d0982737a1069d370dd6cb7bbfd09' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.0.1/containerd-2.0.1-linux-arm64.tar.gz'; sha256='b07120ae227b52edfdb54131d44b13b987b39e8c1f740b0c969b7701e0fad4fa' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.0.1/containerd-2.0.1-linux-ppc64le.tar.gz'; sha256='09a25357343c7336fe519e5fd1a9dd0f22da869e9deda50c2bc61b6e8c9384be' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.0.1/containerd-2.0.1-linux-riscv64.tar.gz'; sha256='3d8d70a4a0d43c6c6d2c75d5101b65ba0ac1c61e0bbd46e8eef922e545d8fe9e' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.0.1/containerd-2.0.1-linux-s390x.tar.gz'; sha256='c377f2f6c305b09dcb425ca5a7b36d73f2969865efef41685ed03cbaecc5ac9e' ;; \
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
