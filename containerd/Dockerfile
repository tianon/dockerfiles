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
ENV CONTAINERD_VERSION 2.3.5
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.3.5/containerd-2.3.5-linux-amd64.tar.gz'; sha256='2f0a095a71e3262d0d91ff0e50e2e4ae73c3866c4d1ff6a15f341097fba3dd44' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.3.5/containerd-2.3.5-linux-arm64.tar.gz'; sha256='06f46cbc073872c5ad1fbc922a53543e9a26b798d62ff106d44639dcb9947942' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.3.5/containerd-2.3.5-linux-ppc64le.tar.gz'; sha256='4ac43bc0a2ff28db50bea9857f80cc1266c93acf190609f68319afd96233e3dc' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.3.5/containerd-2.3.5-linux-riscv64.tar.gz'; sha256='8669b5a689104163ba1cd29a96261da811311983bdf1c50ebb9351c2d74ff967' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.3.5/containerd-2.3.5-linux-s390x.tar.gz'; sha256='dda797416483d1645b279e80f0a7fe18c9e999a3688d10c31ffc8695c3ef865a' ;; \
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
