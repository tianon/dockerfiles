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
ENV RUNC_VERSION 1.1.13
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.1.13/runc.amd64'; sha256='bcfc299c1ab255e9d045ffaf2e324c0abaf58f599831a7c2c4a80b33f795de94' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.1.13/runc.arm64'; sha256='4b93701752f5338ed51592b38e039aef8c1a59856d1225df21eba84c2830743c' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.1.13/runc.armhf'; sha256='4d0e93d3c6ff25aa55df0c890abfd41458d4c5af75b63fea13964724bf5555fb' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.1.13/runc.ppc64le'; sha256='4675d51dc0b08ad8e17d3065f2e4ce47760728945f33d3092385e792357e6519' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.1.13/runc.riscv64'; sha256='d5552409ee70198d54e489a280296de4aee15e1e4e764100b7cb462dbe254420' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.1.13/runc.s390x'; sha256='7a4f0ca44e6ccd937c042b0db60d1f8b12650af843f785e28788d6906899c4f7' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 1.7.21
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-amd64.tar.gz'; sha256='3d1fcdfd0b141f4dc4916b7aee7f9a7773dc344baffc8954e1ca66b1adc5c120' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-arm64.tar.gz'; sha256='7b6b67d998eb86856d23df5d57269c054539072bbb27677975cf78269b2c5c10' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-ppc64le.tar.gz'; sha256='5ce0c1125e8d9ca04e2b524a2bac8b1eb97876c073023d5e083f7da64fcd8207' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-riscv64.tar.gz'; sha256='ca21e34f705c3722c637f6dd6ee839b81a0186349f17c7886566830bd6c4a722' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.21/containerd-1.7.21-linux-s390x.tar.gz'; sha256='2f3332cb47d3d21400bf46c1518ee55be64483f0db2526f2ec64846b94e69ca1' ;; \
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
