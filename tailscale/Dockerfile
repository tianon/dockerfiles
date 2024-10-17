#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		iproute2 \
		iptables \
	; \
	rm -rf /var/lib/apt/lists/*

# https://pkgs.tailscale.com/stable/#static
ENV TAILSCALE_VERSION 1.76.1

RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		amd64)    arch='amd64' ;; \
		arm64)    arch='arm64' ;; \
# Tailscale's "arm" is GOARM=5 (https://github.com/tailscale/tailscale/issues/5482)
		armel)    arch='arm' ;; \
		armhf)    arch='arm' ;; \
		i386)     arch='386' ;; \
		mips64el) arch='mips64le' ;; \
		riscv64)  arch='riscv64' ;; \
		*)        arch='src' ;; \
	esac; \
	if [ "$arch" != 'src' ]; then \
		url="https://pkgs.tailscale.com/stable/tailscale_${TAILSCALE_VERSION}_${arch}.tgz"; \
	else \
		url="https://github.com/tailscale/tailscale/archive/refs/tags/v${TAILSCALE_VERSION}.tar.gz"; \
	fi; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates wget; \
	if [ "$arch" = 'src' ]; then \
		( \
			. /etc/os-release; \
			if [ -n "${VERSION_CODENAME}" ]; then \
				echo "deb https://deb.debian.org/debian $VERSION_CODENAME-backports main" > /etc/apt/sources.list.d/backports.list; \
				apt-get update; \
				apt-get install -y --no-install-recommends -t "$VERSION_CODENAME-backports" golang-go; \
			else \
# must be ports/unstable, so probably new enough Go as-is
				apt-get install -y --no-install-recommends golang-go; \
			fi; \
		); \
	fi; \
	\
	wget -O tailscale.tgz "$url"; \
	\
	mkdir -p /opt/tailscale; \
	tar \
		--extract \
		--file tailscale.tgz \
		--directory /opt/tailscale \
		--strip-components 1 \
		--verbose \
	; \
	rm tailscale.tgz; \
	\
	if [ "$arch" = 'src' ]; then \
		mv /opt/tailscale /tmp/src; \
		( \
			mkdir -p /opt/tailscale; \
			cd /tmp/src; \
			export GOBIN=/opt/tailscale GOCACHE="$PWD/.gocache" GOPATH="$PWD/.gopath"; \
# https://github.com/tailscale/tailscale/blob/v1.56.1/build_dist.sh#L32
# we didn't "git clone" so let's reimplement "build_dist.sh" to the best of our ability
			version="$(cat VERSION.txt)"; \
			go install \
				-ldflags " \
					-X tailscale.com/version.longStamp=$version \
					-X tailscale.com/version.shortStamp=$version \
				" \
				./cmd/tailscale \
				./cmd/tailscaled \
			; \
		); \
		rm -rf /tmp/src; \
	fi; \
	\
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*; \
	\
	ln -sv /opt/tailscale/tailscale* /usr/local/bin/; \
	tailscaled --version; \
	tailscale --version

VOLUME /var/lib/tailscale

CMD ["tailscaled"]
