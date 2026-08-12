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
ENV RUNC_VERSION 1.5.1
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.5.1/runc.amd64'; sha256='177df879d50c913eb205e898d5c1c05a18f574053c0ce5524c471208eaf06f6f' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.5.1/runc.386'; sha256='5f1f84f06019ebfac4254b3bde76cbdea1b690e090e1d8401102e393b18826d4' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.5.1/runc.arm64'; sha256='ca70e7dbd6616ca782a59b5d3ac86909123fdaa9fa3f89dcf29051c70eee7ce9' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.5.1/runc.armhf'; sha256='49f2328d02c55504325de37c2f2ce46a9640983bedece3252499d1d8614fea82' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.5.1/runc.ppc64le'; sha256='9622bbdd5c4368b0673c88c1f258c5ebac82001173a7370c9c9eced50f3d6f10' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.5.1/runc.riscv64'; sha256='fe80f720f38397aa417f42db2584b3de5296d61c133c41a12744589b1305bf7c' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.5.1/runc.s390x'; sha256='aae45fac9bd9d91cc5a3e15f0372083ffc577422ac0af719ec040bf595032822' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.3.4
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.3.4/containerd-2.3.4-linux-amd64.tar.gz'; sha256='9d68969855fbf676cdb8ed758e420fb048d61f984f61de3e53eddfebe484d168' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.3.4/containerd-2.3.4-linux-arm64.tar.gz'; sha256='a985fbb7e18fc0362d31a055338f5d7b0e087a3e27f14c70d1c5965399a29f95' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.3.4/containerd-2.3.4-linux-ppc64le.tar.gz'; sha256='ee53fd0bc41a2283c66f40e4a8f46cd8ae6081f01dfbb0da68e5a71df1297417' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.3.4/containerd-2.3.4-linux-riscv64.tar.gz'; sha256='18e3ec3d2b79cbc5fdf8df04e1e25d0e64949958e8f213dd80692c9f38eba492' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.3.4/containerd-2.3.4-linux-s390x.tar.gz'; sha256='0018af2ed9b1a7f4bfb25e6fc2e9c885c37f32f8cd1755feb675cf4b657bd6ed' ;; \
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
