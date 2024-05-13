#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

# usage:
#   $ docker build --tag tianon/docker-master:build --target build - < Dockerfile
#   $ docker run --rm tianon/docker-master:build tar -cC /artifacts . | tar -xvC target-directory
#
#   $ docker run -d --name dind --privileged --volume dind:/var/lib/docker tianon/docker-master

FROM golang:1.21-bullseye AS build

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		cmake \
		libapparmor-dev \
		libseccomp-dev \
		\
		libbtrfs-dev \
	; \
	rm -rf /var/lib/apt/lists/*

ENV DOCKER_BUILDTAGS \
		apparmor \
		pkcs11 \
		seccomp \
		selinux \
# we cannot support devicemapper properly in a fully-static binary
		exclude_graphdriver_devicemapper

WORKDIR /moby

ARG CLI_GITCOMMIT=0ad1d55b02910f4b40462c0d01aac2934eb0f061
ENV CLI_GITCOMMIT $CLI_GITCOMMIT

RUN set -eux; \
	mkdir cli; \
	cd cli; \
	wget -O /tmp/cli.tgz "https://github.com/docker/cli/archive/$CLI_GITCOMMIT.tar.gz" --progress=dot:giga; \
	tar -xvf /tmp/cli.tgz --strip-components=1; \
	rm /tmp/cli.tgz

RUN set -eux; \
	cd cli; \
	{ echo 'module github.com/docker/cli'; grep -E '^go ' vendor.mod; } | tee go.mod; \
# "go: inconsistent vendoring in /moby/cli:" -> "X@vY: is marked as explicit in vendor/modules.txt, but not explicitly required in go.mod"
	rm vendor/modules.txt; \
# can't use the Makefile anymore thanks to https://github.com/docker/cli/pull/2993 ...
	GOFLAGS='-mod=vendor' CGO_ENABLED=0 GITCOMMIT="$CLI_GITCOMMIT" ./scripts/build/binary; \
	cp -avlL build/docker /usr/local/bin/; \
	docker --version; \
	ldd /usr/local/bin/docker || :

ARG MOBY_GITCOMMIT=cd08d377c5e0348984d1f46d196337d895ec47ad
ENV MOBY_GITCOMMIT $MOBY_GITCOMMIT

RUN set -eux; \
	mkdir engine; \
	cd engine; \
	wget -O /tmp/docker.tgz "https://github.com/moby/moby/archive/$MOBY_GITCOMMIT.tar.gz" --progress=dot:giga; \
	tar -xvf /tmp/docker.tgz --strip-components=1; \
	rm /tmp/docker.tgz

RUN set -eux; \
	cd engine; \
	export TMP_GOPATH=/tmp/gopath; \
# https://github.com/containerd/containerd/issues/5824
# https://github.com/containerd/containerd/commit/00eb74a4ca47d5ad9c7d1171a2929a3da39deee6
	export STATIC=1; \
# TODO ^^ figure out why this is still necessary (because it actually shouldn't be 😭)
	for comp in containerd runc tini; do \
		hack/dockerfile/install/install.sh "$comp"; \
	done; \
	ldd /usr/local/bin/* || :

RUN set -eux; \
	cd engine; \
	{ echo 'module github.com/docker/docker'; grep -E '^go ' vendor.mod; } | tee go.mod; \
# fix "inconsistent vendoring" issue
#	rm vendor/modules.txt; \
	sed -ri '/^[[:space:]]*copy_binaries /d' hack/make/binary-daemon; \
	GOFLAGS='-mod=vendor' DOCKER_GITCOMMIT="$MOBY_GITCOMMIT" hack/make.sh binary; \
	cp -avlL \
		bundles/binary-daemon/dockerd \
		bundles/binary-daemon/docker-proxy \
		hack/dind \
		/usr/local/bin/ \
	; \
	dockerd --version; \
	ldd /usr/local/bin/dockerd /usr/local/bin/docker-proxy || :

# copy all our binaries to a simple fixed location (so they can be easily extracted, if desired)
RUN set -eux; \
	mkdir -p /artifacts; \
	cp -avlL \
		/usr/local/bin/containerd* \
		/usr/local/bin/ctr \
		/usr/local/bin/docker* \
		/usr/local/bin/runc \
		/artifacts/

# verify that every binary can run ~standalone
RUN set -eux; \
	cd /artifacts; \
	for bin in *; do \
		case "$bin" in \
# flag provided but not defined: -version
			containerd-shim | docker-proxy) continue ;; \
			containerd-shim-runc-v2) chroot . "./$bin" -v; continue ;; \
		esac; \
		chroot . "./$bin" --version; \
	done

FROM golang:1.21-bullseye AS buildx

ARG BUILDX_GITCOMMIT=8afeb56a3b00d94b86a98045b5b43f8bba94faad
ENV BUILDX_GITCOMMIT $BUILDX_GITCOMMIT

RUN set -eux; \
	mkdir buildx; \
	cd buildx; \
	wget -O /tmp/buildx.tgz "https://github.com/docker/buildx/archive/$BUILDX_GITCOMMIT.tar.gz" --progress=dot:giga; \
	tar -xvf /tmp/buildx.tgz --strip-components=1; \
	rm /tmp/buildx.tgz

RUN set -eux; \
	cd buildx; \
	GOFLAGS='-mod=vendor' CGO_ENABLED=0 VERSION=HEAD REVISION="$BUILDX_GITCOMMIT" DESTDIR=/usr/local/bin ./hack/build; \
	docker-buildx version; \
	ldd /usr/local/bin/docker-buildx || :; \
	mkdir -p /artifacts; \
	cp -avlL /usr/local/bin/docker-buildx /artifacts/; \
	chroot /artifacts ./docker-buildx version

# TODO compose?

FROM alpine:3.19

RUN set -eux; \
	apk add --no-cache \
		ca-certificates \
		openssh-client \
		\
		ip6tables \
		iptables \
		openssl \
		pigz \
		shadow-uidmap \
		xz \
	;

RUN set -eux; \
	addgroup -S dockremap; \
	adduser -S -G dockremap dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

ENV DOCKER_TLS_CERTDIR=/certs
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client

COPY --from=build /artifacts/ /moby/engine/hack/dind /usr/local/bin/
COPY --from=buildx /artifacts/docker-buildx /usr/local/libexec/docker/cli-plugins/
COPY docker*-entrypoint.sh modprobe.sh /usr/local/bin/

RUN set -eux; \
	containerd --version; \
	containerd-shim-runc-v2 -v; \
	ctr --version; \
	docker --version; \
	docker-init --version; \
	dockerd --version; \
	runc --version; \
	docker buildx version; \
	for sh in /usr/local/bin/*.sh; do \
		sh -n "$sh"; \
	done

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
