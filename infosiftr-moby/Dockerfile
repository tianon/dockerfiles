#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

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

RUN echo 'deb [ allow-insecure=yes trusted=yes ] https://apt.infosiftr.com/moby debian-bullseye stable' > /etc/apt/sources.list.d/moby.list

# http://apt.infosiftr.com/moby/pool/debian-bullseye/stable/moby-cli/
ENV MOBY_CLI_VERSION 20.10.23-1~deb11u0
# http://apt.infosiftr.com/moby/pool/debian-bullseye/stable/moby-engine/
ENV MOBY_ENGINE_VERSION 20.10.23-1~deb11u0
# http://apt.infosiftr.com/moby/pool/debian-bullseye/stable/moby-containerd/
ENV MOBY_CONTAINERD_VERSION 1.6.18-1~deb11u0
# http://apt.infosiftr.com/moby/pool/debian-bullseye/stable/moby-runc/
ENV MOBY_RUNC_VERSION 1.1.4-1~deb11u0

# http://apt.infosiftr.com/moby/pool/debian-bullseye/stable/moby-buildx/
ENV MOBY_BUILDX_VERSION 0.10.3-1~deb11u0

RUN set -eux; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"moby-cli=$MOBY_CLI_VERSION" \
		"moby-engine=$MOBY_ENGINE_VERSION" \
		"moby-containerd=$MOBY_CONTAINERD_VERSION" \
		"moby-runc=$MOBY_RUNC_VERSION" \
		\
		"moby-cli-plugin-buildx=$MOBY_BUILDX_VERSION" \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dockerd --version; \
	docker --version

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
ENV DIND_COMMIT 1f32e3c95d72a29b3eaacba156ed675dba976cb5
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
