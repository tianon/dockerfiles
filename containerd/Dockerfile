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
ENV RUNC_VERSION 1.5.3
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.5.3/runc.amd64'; sha256='50dcc0b257d724fe07f3852c2dda52340223f038227c7572644eec870741223e' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.5.3/runc.386'; sha256='0f2195ceb467e6e8f474b0c2065f1cc37311f6d9542b21c7840f9ac31082fe2e' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.5.3/runc.arm64'; sha256='07b52aee923cc432c38fe4fb6809a08fc6471994efed650af3635350588a20be' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.5.3/runc.armhf'; sha256='411d8039888d71a167e6125f5bef2aef71f2ab80769c507cbeb7f51ba54f6392' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.5.3/runc.ppc64le'; sha256='e773f7c88e536edfbd690ce3aa4efb192beaeabeeaedf8dd4400aff91a97c028' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.5.3/runc.riscv64'; sha256='780dd7e9e269d94c759c8578ef030b18c8d22fc4a43b8209465d5e485015f9bb' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.5.3/runc.s390x'; sha256='159738a9e973b5c74aa9dec39845c36809d9dbf61fd2bc859f6a455436c17976' ;; \
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
