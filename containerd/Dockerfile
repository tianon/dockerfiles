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
ENV RUNC_VERSION 1.3.1
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.3.1/runc.amd64'; sha256='53bfce31ca047e537e0767b21c9d529d4b5b3e1cb9c590ca81654f9a5615d80d' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.3.1/runc.386'; sha256='2f6911230bbbdf415a73216f45e6c6ebc2224f505f7dc29abf0d14b65a8e7104' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.3.1/runc.arm64'; sha256='e531c276312ec701be7edf2b998ac4220c858d02d274bef5546945964792d074' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.3.1/runc.armhf'; sha256='95bfba37f260b7b61c0299ee170c73f51db857756fcce4f27cea285b1165233a' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.3.1/runc.ppc64le'; sha256='a1365d76be84e7ec06340a7e9fd31c0dc89f4e704b7198f2fb0c35788dbacc6f' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.3.1/runc.riscv64'; sha256='206937ab448ecef8440b24c5cdd27431027229d335ab68ac1285eea2a2b6bf6b' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.3.1/runc.s390x'; sha256='90cf081ad0a951d031b13974d6d563da21710a1c35a8c8ca184224fac9ccc902' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.1.4
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-amd64.tar.gz'; sha256='316d510a0428276d931023f72c09fdff1a6ba81d6cc36f31805fea6a3c88f515' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-arm64.tar.gz'; sha256='846d13bc2bf1c01ae2f20d13beb9b3a1e50b52c86e955b4ac7d658f5847f2b0e' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-ppc64le.tar.gz'; sha256='d519e40e266f39cdd68f2c31e2e4e9b70eda09b96f3c3de343a7a3e11d49ad4c' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-riscv64.tar.gz'; sha256='2a6ce108639d5354a504146b82181d11634b8c7dc678dabb03d16d28a8c5725a' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.1.4/containerd-2.1.4-linux-s390x.tar.gz'; sha256='be5b75203ab3ac5b6a9b5c0907315a9e4e1e2e0edd25505f0a783fb929b2cb87' ;; \
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
