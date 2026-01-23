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

FROM golang:1.25-trixie AS build

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		cmake \
		libapparmor-dev \
		libseccomp-dev \
		\
		libbtrfs-dev \
	; \
	apt-get dist-clean

ENV DOCKER_BUILDTAGS \
		apparmor \
		pkcs11 \
		seccomp \
		selinux \
# we cannot support devicemapper properly in a fully-static binary
		exclude_graphdriver_devicemapper

WORKDIR /moby

ARG CLI_GITCOMMIT=d5ed03732077084b5cf3911e26ad25c33d036ca8
ENV CLI_GITCOMMIT $CLI_GITCOMMIT

RUN set -eux; \
	mkdir cli; \
	cd cli; \
	wget -O /tmp/cli.tgz "https://github.com/docker/cli/archive/$CLI_GITCOMMIT.tar.gz" --progress=dot:giga; \
	tar -xvf /tmp/cli.tgz --strip-components=1; \
	rm /tmp/cli.tgz

RUN set -eux; \
	cd cli; \
	grep -E '^(module|go) ' vendor.mod | tee go.mod; \
	GOFLAGS='-mod=vendor -modfile=vendor.mod' CGO_ENABLED=0 GITCOMMIT="$CLI_GITCOMMIT" ./scripts/build/binary; \
	cp -avlL build/docker /usr/local/bin/; \
	docker --version; \
	ldd /usr/local/bin/docker || :

ARG MOBY_GITCOMMIT=a8389f405322587b019c1a0df40d3b6bf8d7bbdd
ENV MOBY_GITCOMMIT $MOBY_GITCOMMIT

RUN set -eux; \
	mkdir engine; \
	cd engine; \
	wget -O /tmp/docker.tgz "https://github.com/moby/moby/archive/$MOBY_GITCOMMIT.tar.gz" --progress=dot:giga; \
	tar -xvf /tmp/docker.tgz --strip-components=1; \
	rm /tmp/docker.tgz

RUN set -eux; \
	cd engine; \
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
#		/usr/local/bin/containerd* \
#		/usr/local/bin/ctr \
		/usr/local/bin/docker* \
#		/usr/local/bin/runc \
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

FROM golang:1.25-trixie AS buildx

ARG BUILDX_GITCOMMIT=44945d71ff077ce7fc142fbdee6acec8d9acb630
ENV BUILDX_GITCOMMIT $BUILDX_GITCOMMIT

RUN set -eux; \
	mkdir buildx; \
	cd buildx; \
	wget -O /tmp/buildx.tgz "https://github.com/docker/buildx/archive/$BUILDX_GITCOMMIT.tar.gz" --progress=dot:giga; \
	tar -xvf /tmp/buildx.tgz --strip-components=1; \
	rm /tmp/buildx.tgz

RUN set -eux; \
	cd buildx; \
	CGO_ENABLED=0 go build -trimpath -mod=vendor -ldflags "-w \
		-X github.com/docker/buildx/version.Version=HEAD \
		-X github.com/docker/buildx/version.Revision=$BUILDX_GITCOMMIT \
		-X github.com/docker/buildx/version.Package=github.com/docker/buildx \
	" -o /usr/local/bin/docker-buildx ./cmd/buildx; \
	docker-buildx version; \
	ldd /usr/local/bin/docker-buildx || :; \
	mkdir -p /artifacts; \
	cp -avlL /usr/local/bin/docker-buildx /artifacts/; \
	chroot /artifacts ./docker-buildx version

# TODO compose?

FROM tianon/containerd

RUN set -eux; \
	containerd --version; \
	ctr --version; \
	runc --version; \
	command -v dind

RUN set -eux; \
	apt-get install --update -y --no-install-recommends \
		ca-certificates \
		openssh-client \
		\
		iproute2 \
		iptables \
		openssl \
		pigz \
		procps \
		psmisc \
		xz-utils \
		\
# TODO someday, install tini-static instead
		tini \
	; \
	apt-get dist-clean; \
	tini="$(command -v tini-static)"; \
	ln -svfT "$tini" /usr/local/bin/docker-init

RUN set -eux; \
	addgroup --system dockremap; \
	adduser --system --ingroup dockremap dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

ENV DOCKER_TLS_CERTDIR=/certs
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client

COPY --from=build /artifacts/ /moby/engine/hack/dind /usr/local/bin/
COPY --from=buildx /artifacts/docker-buildx /usr/local/libexec/docker/cli-plugins/
COPY docker*-entrypoint.sh modprobe.sh /usr/local/bin/

RUN set -eux; \
	docker --version; \
	docker-init --version; \
	dockerd --version; \
	docker buildx version; \
	for sh in /usr/local/bin/*.sh; do \
		sh -n "$sh"; \
	done

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
