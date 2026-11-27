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
ENV RUNC_VERSION 1.6.0
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.6.0/runc.amd64'; sha256='84da88622bbfa6dcccf52262ef52e81847ff5831190be71fdc7db1358bd199a4' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.6.0/runc.386'; sha256='fc5c34d45cfd2a4c99a32df97fa92372daa8e1f27d92b00f8d701f782fe1ed08' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.6.0/runc.arm64'; sha256='604f08e0fabd63a58853210cee48f1edd16aa79bbef15a1a7d8f07f9f4fe2f72' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.6.0/runc.armhf'; sha256='f82205ac1fa0a88341baa9e86b105ce1232c6a06b6f16ab5cb73566f177ab8a1' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.6.0/runc.ppc64le'; sha256='4f4ca507af208315af0ea1180d752b24af6e6b74e6429006987970e94ee055c7' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.6.0/runc.riscv64'; sha256='24a4e96a80d3bf679236a80d3898224e8b73db828979832176b7edb3262cc723' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.6.0/runc.s390x'; sha256='70bad19499c4015cfc9525a81d43b159c63698485fdb37ce4378a6ca22d40b1f' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.4.2
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.4.2/containerd-2.4.2-linux-amd64.tar.gz'; sha256='35880c1dd4627e8ce56526bfabb39c144e83458ffdb197ce6f05d17d94d7d91e' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.4.2/containerd-2.4.2-linux-arm64.tar.gz'; sha256='fdfab81a86192ddb8165d72f116ec985485c9e12505e323c4f4579c48020f276' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.4.2/containerd-2.4.2-linux-ppc64le.tar.gz'; sha256='0b9dbbec5fae67a4fc989a4444d750b5bb298f1fd253218208e379aa7128cb99' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.4.2/containerd-2.4.2-linux-riscv64.tar.gz'; sha256='1f4baca71f1576c6c27975964028597859da3a7a1c8427789bbc4c44418341f1' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.4.2/containerd-2.4.2-linux-s390x.tar.gz'; sha256='0aa23d24ff93a10a01b8c9b48a83e13c1f9c97035cdd104da14f3ff5f2fe4b8a' ;; \
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
