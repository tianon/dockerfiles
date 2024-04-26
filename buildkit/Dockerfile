#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

# syntax=docker/dockerfile:1.5

FROM --platform=$BUILDPLATFORM golang:1.21 AS build

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		patch \
	; \
	rm -rf /var/lib/apt/lists/*

ENV CGO_ENABLED 0

ARG TARGETOS TARGETARCH TARGETVARIANT
ENV GOOS=$TARGETOS GOARCH=$TARGETARCH VARIANT=$TARGETVARIANT

# https://github.com/moby/buildkit/releases
ENV BUILDKIT_VERSION 0.13.2

# pkg/mod/github.com/moby/buildkit@v0.12.0/snapshot/diffapply_unix.go:131:8: cannot use stat.Dev (variable of type uint32) as uint64 value in struct literal
# pkg/mod/github.com/moby/buildkit@v0.12.0/snapshot/diffapply_unix.go:300:12: cannot use unix.Mkdev(0, 0) (value of type uint64) as uint32 value in struct literal
COPY mips64le.patch /tmp/

RUN set -eux; \
	case "$GOARCH" in \
		arm) export GOARM="${VARIANT#v}" ;; \
		amd64) export GOAMD64="$VARIANT" ;; \
		*) [ -z "$VARIANT" ] ;; \
	esac; \
	go env | grep -E 'OS=|ARCH=|ARM=|AMD64='; \
	git clone -b "v$BUILDKIT_VERSION" --depth 1 'https://github.com/moby/buildkit.git' /app; \
	cd /app; \
	patch -p1 --input=/tmp/mips64le.patch; \
# TODO https://github.com/moby/buildkit/blob/v0.12.2/Dockerfile#L79
	go build -o /buildkitd -trimpath -ldflags '-d -w' ./cmd/buildkitd; \
	go build -o /buildctl -trimpath -ldflags '-d -w' ./cmd/buildctl

FROM --platform=$TARGETPLATFORM infosiftr/moby

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends git; \
	rm -rf /var/lib/apt/lists/*

COPY --from=build --link /buildkitd /buildctl /usr/local/bin/
COPY buildkitd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/buildkit

# https://github.com/docker/buildx/issues/484#issuecomment-749352728
ENV BUILDKIT_STEP_LOG_MAX_SIZE -1
ENV BUILDKIT_STEP_LOG_MAX_SPEED -1

ENTRYPOINT ["buildkitd-entrypoint.sh"]
CMD []
