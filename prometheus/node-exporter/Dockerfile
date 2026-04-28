#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.11.0

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
		riscv64)  arch='riscv64' ;; \
		s390x)    arch='s390x' ;; \
		*)        arch='src' ;; \
	esac; \
	if [ "$arch" != 'src' ]; then \
		filename="node_exporter-${NODE_EXPORTER_VERSION}.linux-${arch}.tar.gz"; \
		case "$filename" in \
			'node_exporter-1.11.0.linux-386.tar.gz') sha256='b19113e5c6b5af4f677614b23d2e609cd2d2c4ca1cca792b9d507a83ce7594c1' ;; \
			'node_exporter-1.11.0.linux-amd64.tar.gz') sha256='4f8fbd23b8380b8fb720b125fb9029de261dc5fcd68bfe81ae010c0d32f5f6c3' ;; \
			'node_exporter-1.11.0.linux-arm64.tar.gz') sha256='cd09ceffd418e91c25365ad008b2baac88fa1743632b71c620829d3d5596b141' ;; \
			'node_exporter-1.11.0.linux-armv5.tar.gz') sha256='32e895bf42392c62bb593b96586175cd314c235640e89bf17023a66530f38185' ;; \
			'node_exporter-1.11.0.linux-armv6.tar.gz') sha256='e76780b47f6b801338419a2f7e8058eb24f50e118d531e177724ce6918cc31da' ;; \
			'node_exporter-1.11.0.linux-armv7.tar.gz') sha256='b90efc7c6cc470494af9c9b8c934a6199cf46b4484a7372da11084220af91201' ;; \
			'node_exporter-1.11.0.linux-mips.tar.gz') sha256='015972561c728dc84848abfa84a51c903a722b4c5ecb3c54df69c5c7f95f1f49' ;; \
			'node_exporter-1.11.0.linux-mips64.tar.gz') sha256='7d2be8ec70ee714af5d1a4175ffd89f474a925f98f5fc85a16d3888c9d98c008' ;; \
			'node_exporter-1.11.0.linux-mips64le.tar.gz') sha256='ae4ee9d9592c2648dbd0556ce8d4af168f32969226ea718896974b29a256ef00' ;; \
			'node_exporter-1.11.0.linux-mipsle.tar.gz') sha256='56ea612fa6cc4a17b2a428263211ae535717fad89d3aa4f5ed3264f1991f3b54' ;; \
			'node_exporter-1.11.0.linux-ppc64.tar.gz') sha256='247eb037c142e6d5f39318624400d3155d59e5ae3b31eaff6ced31c0162c09e7' ;; \
			'node_exporter-1.11.0.linux-ppc64le.tar.gz') sha256='945cd5fcb3be8ccdbc57a6ed507343fcbd680369a84f94879ce7b525b9106b9b' ;; \
			'node_exporter-1.11.0.linux-riscv64.tar.gz') sha256='aa4582b2a1d09172f3c46b3724fbb2f7a571c53b71bb85d05b17d97da53f23ba' ;; \
			'node_exporter-1.11.0.linux-s390x.tar.gz') sha256='2880e4d2fdea0571923f1a9b1a8067023a09b6adc93674a57130fe65cb01c555' ;; \
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
	apt-get dist-clean; \
	\
	node_exporter --version

VOLUME /opt/node-exporter/data

EXPOSE 9100
CMD ["node_exporter"]
