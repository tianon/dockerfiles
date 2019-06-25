# usage:
#   $ docker build -t some-name - < Dockerfile.build
#   $ docker run --rm some-name tar -cC /artifacts . | tar -xvC target-directory

FROM golang:1.8-stretch

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		cmake \
		libapparmor-dev \
		libseccomp-dev \
		\
		btrfs-progs \
		libdevmapper-dev \
	; \
	rm -rf /var/lib/apt/lists/*

ENV DOCKER_BUILDTAGS \
		apparmor \
		pkcs11 \
		seccomp \
		selinux \
# we cannot support devicemapper properly in a fully-static binary
		exclude_graphdriver_devicemapper

ENV DOCKER_GITCOMMIT dcb3911f764f51beca07259f263dc792d380b7aa

WORKDIR /go/src/github.com/docker/docker
RUN set -ex; \
	wget -O /tmp/docker.tgz "https://github.com/docker/docker/archive/${DOCKER_GITCOMMIT}.tar.gz"; \
	tar -xvf /tmp/docker.tgz --strip-components=1; \
	rm /tmp/docker.tgz

RUN set -ex; \
	./hack/dockerfile/install-binaries.sh \
		containerd \
		runc \
		tini \
	; \
	CGO_ENABLED=0 ./hack/dockerfile/install-binaries.sh \
		dockercli \
		proxy \
	; \
	ldd /usr/local/bin/docker* || :

RUN ./hack/make.sh binary

# copy all our binaries to a simple fixed location
RUN set -ex; \
	mkdir -p /artifacts; \
	cp -avlL \
		/usr/local/bin/docker* \
		bundles/latest/binary-daemon/dockerd \
		/artifacts/

# verify that every binary can run ~standalone
RUN set -ex; \
	cd /artifacts; \
	for bin in *; do \
		case "$bin" in \
# flag provided but not defined: -version
			docker-containerd-shim|docker-proxy) continue ;; \
		esac; \
		chroot . "./$bin" --version; \
	done
