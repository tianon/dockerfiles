#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.12.0

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
			'node_exporter-1.12.0.linux-386.tar.gz') sha256='19c4998f9ae5c04fe46158f0d7fb8ccf92829a4f74e46fdf154371775cf1bde3' ;; \
			'node_exporter-1.12.0.linux-amd64.tar.gz') sha256='b206d98e98a431f2687d4c217abb4b15c46a6b272896113ce9a1585cf1a75d1f' ;; \
			'node_exporter-1.12.0.linux-arm64.tar.gz') sha256='4ea211ce95224acb7f7c932693cb25f91f7fbe202c86bf6dc943c8569b3f6bac' ;; \
			'node_exporter-1.12.0.linux-armv5.tar.gz') sha256='970e0385e2e59cc9dfc03d7c9596c52638dbb15fb425eba5b87f286ca655c039' ;; \
			'node_exporter-1.12.0.linux-armv6.tar.gz') sha256='33b121e60e759312fece548777239f8b53b057a5bcb0402c2f8e852b40e444d8' ;; \
			'node_exporter-1.12.0.linux-armv7.tar.gz') sha256='75f0716a2a9df6858f1a2deeafcaf57be31bfb06125ab0b8747f54477a565b9b' ;; \
			'node_exporter-1.12.0.linux-mips.tar.gz') sha256='c4be10b92b3754776e0d0453a0ef03cda04caf236c8fc8ce26524af8565af00d' ;; \
			'node_exporter-1.12.0.linux-mips64.tar.gz') sha256='68acd1071379202f9fe0aa928f4b969542bd8699a0af2b87d0cd120b7edf3904' ;; \
			'node_exporter-1.12.0.linux-mips64le.tar.gz') sha256='e01a8abaad28f8cf7681176a1775cc1360cd981c7c4406ef5e07517074fd49eb' ;; \
			'node_exporter-1.12.0.linux-mipsle.tar.gz') sha256='04a9a23d8b5c07f69109db05993a513be5ef290ecdafefb532151db0befd2412' ;; \
			'node_exporter-1.12.0.linux-ppc64.tar.gz') sha256='4cfa06859621b5e4c8e854e650d8cd8e3a992f0c1aabb0b14da9ad13131430f1' ;; \
			'node_exporter-1.12.0.linux-ppc64le.tar.gz') sha256='03b07001917599dee590467bfdf53336395672956bf33d0e05f2d7a152925f9a' ;; \
			'node_exporter-1.12.0.linux-riscv64.tar.gz') sha256='482b0f9a34d6e0ccff5aa3eca046e689cc0c1cd3a779039ac0563f6b5aac2dab' ;; \
			'node_exporter-1.12.0.linux-s390x.tar.gz') sha256='8e70471418ee5e707b47ec6aa11034a1cdf028872397792693a8323aeeebde8d' ;; \
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
