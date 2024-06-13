#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

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
ENV CONTAINERD_VERSION 1.7.18
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.18/containerd-1.7.18-linux-amd64.tar.gz'; sha256='a24b05b341c155a0ec367d3d0fd1d437c09a0261dffdecc0e44e9abbf2d02aca' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.18/containerd-1.7.18-linux-arm64.tar.gz'; sha256='e80ce87b469af03b3bdcf68b95f0f4a303787ae247581bcd42f04acf1ad4c24d' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.18/containerd-1.7.18-linux-ppc64le.tar.gz'; sha256='d6cfb3bc8fbdead7d435d5f3f6b1913b5896f7f97102c1bbad206f9123c2a5d3' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.18/containerd-1.7.18-linux-riscv64.tar.gz'; sha256='7f95f6dc0a2a9404780335cc757f3eb13edaef5106068dc6580c72128a265744' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.18/containerd-1.7.18-linux-s390x.tar.gz'; sha256='c291585a18b06830e6bcf43ba39da2884aaf353f4679f6cd1de606bbaeb6418a' ;; \
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

# use "docker run ... dind containerd" if you want to run real containers (with "--privileged")
# see also Dockerfile.c8dind (or "tianon/containerd:c8dind")
