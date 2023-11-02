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
ENV DIND_COMMIT d58df1fc6c866447ce2cd129af10e5b507705624
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	sh -n /usr/local/bin/dind; \
	chmod +x /usr/local/bin/dind

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.1.10
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.amd64'; sha256='81f73a59be3d122ab484d7dfe9ddc81030f595cc59968f61c113a9a38a2c113a' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.arm64'; sha256='4830afd426bdeacbdf9cb8729524aa2ed51790b8c4b28786995925593708f1c8' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.armhf'; sha256='a78cf549da89cc39d2464a5433e3db50191b9fc69f0165cefb61bbfbf0ceb7de' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.ppc64le'; sha256='94a091c06c363e4af7be398dc31fa6e02576d5ecda6de1cbf3a08fe8662bf678' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.riscv64'; sha256='0fcff1af876effb69c670c335e44e0afa4c3523695e382dc8740301c8dc67160' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.1.10/runc.s390x'; sha256='1940ef78f89a4ec2951ef9013b2572dd916888712d3e96ad29a928523a6d1104' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 1.7.8
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v1.7.8/containerd-1.7.8-linux-amd64.tar.gz'; sha256='5f1d017a5a7359514d6187d6656e88fb2a592d107e6298db7963dbddb9a111d9' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v1.7.8/containerd-1.7.8-linux-arm64.tar.gz'; sha256='3fc551e8f51150804d80cc1958a271bd2252b6334f0355244d0faa5da7fa55d1' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v1.7.8/containerd-1.7.8-linux-ppc64le.tar.gz'; sha256='2b563df9e1bddc96a99a023963c99b5faf3066d3fcbc23ff44ba24229e939444' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v1.7.8/containerd-1.7.8-linux-riscv64.tar.gz'; sha256='555be0611122401fc25afde3cafd7bc78f2ab4bacb2b46f49ed37eb6469e0fb3' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v1.7.8/containerd-1.7.8-linux-s390x.tar.gz'; sha256='ab87d460f77b4ac5f4277888d5784f9199e2dc98fd96c2cedb9a6fee0aa659e5' ;; \
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
