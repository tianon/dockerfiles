#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.6.1

RUN set -ex; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		amd64)    arch='amd64' ;; \
		arm64)    arch='arm64' ;; \
		armel)    arch='armv5' ;; \
		armhf)    arch='armv7' ;; \
		i386)     arch='386' ;; \
		mips64el) arch='mips64le' ;; \
		ppc64el)  arch='ppc64le' ;; \
		s390x)    arch='s390x' ;; \
		*)        arch='src' ;; \
	esac; \
	if [ "$arch" != 'src' ]; then \
		filename="node_exporter-${NODE_EXPORTER_VERSION}.linux-${arch}.tar.gz"; \
		case "$filename" in \
			'node_exporter-1.6.1.linux-386.tar.gz') sha256='e81a7aeecc2b7dc771b77b999e89884fab83c129818a0631f4a3ecf7279a3612' ;; \
			'node_exporter-1.6.1.linux-amd64.tar.gz') sha256='ecc41b3b4d53f7b9c16a370419a25a133e48c09dfc49499d63bcc0c5e0cf3d01' ;; \
			'node_exporter-1.6.1.linux-arm64.tar.gz') sha256='f99ea62cec600bca5c926d300522d7a3bb797592d70dc1bcdc20b57811f1d439' ;; \
			'node_exporter-1.6.1.linux-armv5.tar.gz') sha256='dbb0a44401d304009af03f437c854a401bfe7597a4b69cb7fc6700793088065b' ;; \
			'node_exporter-1.6.1.linux-armv6.tar.gz') sha256='7e7999318a165bd2e71e734ec6b86570212bec5078d478c4803d19c96e832197' ;; \
			'node_exporter-1.6.1.linux-armv7.tar.gz') sha256='9212d3c7b10f7ff904ed2dda038fddf4a4cc2f5cc4ebb4afe83f9159b5bbc5bb' ;; \
			'node_exporter-1.6.1.linux-mips.tar.gz') sha256='5f3f8a874617b9c2c8c174fef8d46d815f6d384622728eaf13c6ad498af9c9df' ;; \
			'node_exporter-1.6.1.linux-mips64.tar.gz') sha256='cff89d90b22c6c16723bfa7d5ed1bb5d245f41fd0b1ef7810cf2d606208c0ed7' ;; \
			'node_exporter-1.6.1.linux-mips64le.tar.gz') sha256='207df09b72d2dbccdabee0154a3d292a140e26925d61ae6e31015716c7868783' ;; \
			'node_exporter-1.6.1.linux-mipsle.tar.gz') sha256='75e3675ed8286ba8274552f9ea83ae8a70c312ffefd7f1687a1ac88bf0d5d1d3' ;; \
			'node_exporter-1.6.1.linux-ppc64.tar.gz') sha256='3956593d3bb5b351cb8e415124d0fc40ec9010fb6450dd6e29d7823f2673a02a' ;; \
			'node_exporter-1.6.1.linux-ppc64le.tar.gz') sha256='f8ef54b6b6c899c9b81ad0150612d897be8d88f8ef17ab70d3a82f7bc36b0dd0' ;; \
			'node_exporter-1.6.1.linux-s390x.tar.gz') sha256='3c2d3b8f4da2adda2897195257fc5a633795811893ac11208f525bfb75402734' ;; \
			*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
		esac; \
		url="https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/$filename"; \
	else \
		url="https://github.com/prometheus/node_exporter/archive/refs/tags/v${NODE_EXPORTER_VERSION}.tar.gz"; \
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
	wget -O /tmp/node-exporter.tar.gz "$url"; \
	if [ "$arch" != 'src' ]; then \
		echo "$sha256 */tmp/node-exporter.tar.gz" | sha256sum --strict --check -; \
	fi; \
	\
	tar \
		--extract \
		--file /tmp/node-exporter.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/node-exporter.tar.gz; \
	\
	if [ "$arch" = 'src' ]; then \
		dir="$PWD"; \
		cd /; \
		mv "$dir" /tmp/src; \
		( \
			mkdir -p "$dir"; \
			cd /tmp/src; \
			export GOBIN="$dir" GOCACHE="$PWD/.gocache" GOPATH="$PWD/.gopath"; \
			go install \
				-a -tags 'netgo osusergo static_build' \
				-ldflags " \
					-X github.com/prometheus/common/version.Version=$NODE_EXPORTER_VERSION \
					-X github.com/prometheus/common/version.Revision=v$NODE_EXPORTER_VERSION \
				" \
				. \
			; \
		); \
		rm -rf /tmp/src; \
	fi; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*; \
	\
	node_exporter --version

VOLUME /opt/node-exporter/data

EXPOSE 9100
CMD ["node_exporter"]
