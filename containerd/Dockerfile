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
ENV CONTAINERD_VERSION 1.7.16
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.16/containerd-1.7.16-linux-amd64.tar.gz'; sha256='4f4f2c3c7d14fd59a404961a3a3341303c2fdeeba0e78808c209f606e828f99c' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.16/containerd-1.7.16-linux-arm64.tar.gz'; sha256='2d4373de40a6f58cd0f29377c0257b35697a987248e6268520586996771d7a75' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.16/containerd-1.7.16-linux-ppc64le.tar.gz'; sha256='d0add7a55a5d4411cafb276469d2b78bc3ada11cb4b444b9e35f9ef60c00960d' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.16/containerd-1.7.16-linux-riscv64.tar.gz'; sha256='8cee651d8997df66c0b205b57280aecd7854506e2fa6a0795e5366e84b362d0b' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.16/containerd-1.7.16-linux-s390x.tar.gz'; sha256='b6b0d162e0cb864739ce9e2aa7e88d3c596bb0bafae9d0619f69d5ec03a935b3' ;; \
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
