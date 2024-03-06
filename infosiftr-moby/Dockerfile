#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		iproute2 \
		kmod \
# DOCKER_HOST=ssh://... -- https://github.com/docker/cli/pull/1014
		openssh-client \
	; \
	rm -rf /var/lib/apt/lists/*

# https://apt.tianon.xyz/moby
# https://apt.tianon.xyz/moby/dists/bookworm/tianon-moby.sources
RUN echo 'deb [ allow-insecure=yes trusted=yes ] https://apt.tianon.xyz/moby bookworm main' > /etc/apt/sources.list.d/moby.list
# TODO deb822

# http://apt.tianon.xyz/moby/pool/bookworm/main/moby-engine/
ENV MOBY_ENGINE_VERSION 20.10.27-2~deb12u0
# http://apt.tianon.xyz/moby/pool/bookworm/main/moby-containerd/
ENV MOBY_CONTAINERD_VERSION 1.6.28-1~deb12u0
# http://apt.tianon.xyz/moby/pool/bookworm/main/moby-runc/
ENV MOBY_RUNC_VERSION 1.1.12-1~deb12u0

# http://apt.tianon.xyz/moby/pool/bookworm/main/moby-cli/
ENV MOBY_CLI_VERSION 20.10.27-1~deb12u0
# http://apt.tianon.xyz/moby/pool/bookworm/main/moby-buildx/
ENV MOBY_BUILDX_VERSION 0.12.1-1~deb12u0

RUN set -eux; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"moby-engine=$MOBY_ENGINE_VERSION" \
		"moby-containerd=$MOBY_CONTAINERD_VERSION" \
		"moby-runc=$MOBY_RUNC_VERSION" \
		\
		"moby-cli=$MOBY_CLI_VERSION" \
		"moby-cli-plugin-buildx=$MOBY_BUILDX_VERSION" \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dockerd --version; \
	containerd --version; \
	runc --version; \
	\
	docker --version; \
	docker buildx version

COPY modprobe.sh /usr/local/bin/modprobe
COPY docker-entrypoint.sh /usr/local/bin/

# https://github.com/docker-library/docker/pull/166
#   dockerd-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-generating TLS certificates
#   docker-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-setting DOCKER_TLS_VERIFY and DOCKER_CERT_PATH
# (For this to work, at least the "client" subdirectory of this path needs to be shared between the client and server containers via a volume, "docker cp", or other means of data sharing.)
ENV DOCKER_TLS_CERTDIR=/certs
# also, ensure the directory pre-exists and has wide enough permissions for "dockerd-entrypoint.sh" to create subdirectories, even when run in "rootless" mode
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client
# (doing both /certs and /certs/client so that if Docker does a "copy-up" into a volume defined on /certs/client, it will "do the right thing" by default in a way that still works for rootless users)

# dind

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		iproute2 \
		iptables \
		openssl \
		procps \
		psmisc \
		wget \
		xz-utils \
# pigz: https://github.com/moby/moby/pull/35697 (faster gzip implementation)
		pigz \
	; \
	rm -rf /var/lib/apt/lists/*

# set up subuid/subgid so that "--userns-remap=default" works out-of-the-box
RUN set -eux; \
	addgroup --system dockremap; \
	adduser --system --ingroup dockremap dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

# https://github.com/docker/docker/tree/master/hack/dind
ENV DIND_COMMIT 65cfcc28ab37cb75e1560e4b4738719c07c6618e
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 2376

# https://github.com/docker/buildx/issues/484#issuecomment-749352728
ENV BUILDKIT_STEP_LOG_MAX_SIZE -1
ENV BUILDKIT_STEP_LOG_MAX_SPEED -1

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
