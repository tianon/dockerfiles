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
ENV RUNC_VERSION 1.1.12
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.amd64'; sha256='aadeef400b8f05645768c1476d1023f7875b78f52c7ff1967a6dbce236b8cbd8' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.arm64'; sha256='879f910a05c95c10c64ad8eb7d5e3aa8e4b30e65587b3d68e009a3565aed5bb8' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.armhf'; sha256='d0d1c7828eacb28bfec21d437c99308c380b31c4898a36c2c4a23c79e036295f' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.ppc64le'; sha256='4069d1d57724126e116ad6dbd84409082d1b0afee1ee960b17558f146a742bb6' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.riscv64'; sha256='2437db8883422714e7bce3dc6759e31263470e25f854ffa043b1972449a08cc2' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.s390x'; sha256='8fd751c034f751ec7b34d1c404c36009adcd3ef1c8f22f6031df3f69e9454b6f' ;; \
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
