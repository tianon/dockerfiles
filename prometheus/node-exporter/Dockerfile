#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.13.1

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
			'node_exporter-1.13.1.linux-386.tar.gz') sha256='e17aed2461c83e10b0e65c6168ba1bf969e0501036174a1143063c7c1120883a' ;; \
			'node_exporter-1.13.1.linux-amd64.tar.gz') sha256='5c00c5234f1ee45900b25539a5a0ab82146a098c15c16a4ec3bc855b597a6477' ;; \
			'node_exporter-1.13.1.linux-arm64.tar.gz') sha256='96d82b3b261803f89815b325601cbbc58f49cd8265617bfde1527211934bdd48' ;; \
			'node_exporter-1.13.1.linux-armv5.tar.gz') sha256='bfd27360a8a3eaed3138c9f5866981d27c42fcb98c82560cf5056b56da9ce02b' ;; \
			'node_exporter-1.13.1.linux-armv6.tar.gz') sha256='0fc0fbe61e221b5ab40ef0c0b1fbda671566a23ba321f1bae386e48347b52a22' ;; \
			'node_exporter-1.13.1.linux-armv7.tar.gz') sha256='a8b57fa16b003f98d9fc3deb4d5f3b12fb10cb0776d274f742be6e5ee07f30dc' ;; \
			'node_exporter-1.13.1.linux-mips.tar.gz') sha256='4dd21c7c41f90d4347a3c5ba15546c418c0c1e1c83c05a3279b308f6a571c6dd' ;; \
			'node_exporter-1.13.1.linux-mips64.tar.gz') sha256='0973d74dbad86e1cffcf57ad4274706bcd9d6be96ec483eb7a48522f1bad6643' ;; \
			'node_exporter-1.13.1.linux-mips64le.tar.gz') sha256='cb2a0f183de9748f011fcddf372ca6c69f844a320ad1e4b7e7ee21bc19d60574' ;; \
			'node_exporter-1.13.1.linux-mipsle.tar.gz') sha256='f71b60cfa1356efffb10401cc2f9a8871994cbf0a31476ae1c033299894ba467' ;; \
			'node_exporter-1.13.1.linux-ppc64.tar.gz') sha256='5b9db8d3d432bdca325c83fa454d03ed8c8c6913024dca41edaff2cb4842ee2f' ;; \
			'node_exporter-1.13.1.linux-ppc64le.tar.gz') sha256='b3640423a1ba33fb0ec5397fcd6b4b157a9bedc28a6a3a293270ec1131f0b742' ;; \
			'node_exporter-1.13.1.linux-riscv64.tar.gz') sha256='33d4c64cc2542b568ad9ac3babb9221b8f4527361c9a9d6833a4ea176e840edf' ;; \
			'node_exporter-1.13.1.linux-s390x.tar.gz') sha256='fe6c2ebbeeb3cd31d8c2400cab7d135f765c7fe9cc68a518446c3a1cb624a8cb' ;; \
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
