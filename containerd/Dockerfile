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
ENV DIND_COMMIT c43aa0b6aa7c88343f0951ba9a39c69aa51c54ef
# https://github.com/docker/docker/commit/c43aa0b6aa7c88343f0951ba9a39c69aa51c54ef -- 2025-01-29T19:25:45.000+01:00 (@1738175145)
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://github.com/docker/docker/raw/${DIND_COMMIT}/hack/dind"; \
	sh -n /usr/local/bin/dind; \
	chmod +x /usr/local/bin/dind

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.2.5
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.2.5/runc.amd64'; sha256='fbd851fce6a8e0d67a9d184ea544c2abf67c9fd29b80fcc1adf67dfe9eb036a1' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.2.5/runc.386'; sha256='498dae87debc81116e072c71d37c4dee5dfc8b266dd909b1fcf3819d3524c363' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.2.5/runc.arm64'; sha256='bfc6575f4c601740539553b639ad6f635c23f76695ed484171bd864df6a23f76' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.2.5/runc.armhf'; sha256='d3ae5cb7b024833209ab54a2233fd30412220060d02ee19a26add6c9ad414897' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.2.5/runc.ppc64le'; sha256='3764385971ac719535425629e1ac4d451934392993779ee9e8e8ed7566715f5f' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.2.5/runc.riscv64'; sha256='a6ee65efe60033e3315f4310eea67cb49751f0aa11767ccb7d4a276bce487784' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.2.5/runc.s390x'; sha256='aa63ff8131086a0901edf7b57ceff4a432289fc1c89dda9dd3976fa280d4fad8' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.0.3
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.0.3/containerd-2.0.3-linux-amd64.tar.gz'; sha256='ac70856f1d8bd3aa9ca5d62db5516b86dfa0f934c1fd1d1c5fa4422dd12ba45e' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.0.3/containerd-2.0.3-linux-arm64.tar.gz'; sha256='3701008e72e983259afaa594cca5d8126e78e38cf0a586a1f6971cb3f61c4b6b' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.0.3/containerd-2.0.3-linux-ppc64le.tar.gz'; sha256='2f0faa0086ae81d00680367ee9d75aafd3c4ca4535362db83fea62dd19c47079' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.0.3/containerd-2.0.3-linux-riscv64.tar.gz'; sha256='623dcd66ee7b0fff2c6e1bcfbcadf814e0ebf754645de970680b2c49182dfed3' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.0.3/containerd-2.0.3-linux-s390x.tar.gz'; sha256='fb4796b4707e128fd6392cdd97824ef80f9ac6dcb6a1fd188d76399722076c04' ;; \
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
