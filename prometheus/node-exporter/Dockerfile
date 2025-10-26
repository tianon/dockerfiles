#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.10.0

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
			'node_exporter-1.10.0.linux-386.tar.gz') sha256='449ed18832820896771d5fa2f6d2104cddc578d14b34607941afcff7e2af2052' ;; \
			'node_exporter-1.10.0.linux-amd64.tar.gz') sha256='6c2a4d886fc82743f7f97b8e0a0cd80ab0199939edce3cf0b9b36dad8d48d9b4' ;; \
			'node_exporter-1.10.0.linux-arm64.tar.gz') sha256='ecd320c7578745007108e98ce170ea0d12e30480eabbce199a041cd62450a961' ;; \
			'node_exporter-1.10.0.linux-armv5.tar.gz') sha256='795c1f0a364f86daa119628f6a02f33df1e149339aa1d77571c74a20940eab56' ;; \
			'node_exporter-1.10.0.linux-armv6.tar.gz') sha256='14420b4ec1948a001910e931d354b1ed0e35041e9768c9036b2902478931ec11' ;; \
			'node_exporter-1.10.0.linux-armv7.tar.gz') sha256='131588ec506bd5c74f455fb149b2bdce35209d2b905ffd5cf8dcbc93a2ec2e94' ;; \
			'node_exporter-1.10.0.linux-mips.tar.gz') sha256='c5c64e0de4b8b2e803691b3d8632504f6caeb31d9021b94df4ac30dd5a7f07f7' ;; \
			'node_exporter-1.10.0.linux-mips64.tar.gz') sha256='c6b6d8d0508d5232bb9431ade95d6eb2bd79c906c6601eb39e4877409db794da' ;; \
			'node_exporter-1.10.0.linux-mips64le.tar.gz') sha256='07748753fe77a794ffe8c032e4f2c43c1cac3b3c60d95b163bfd7a55581910d7' ;; \
			'node_exporter-1.10.0.linux-mipsle.tar.gz') sha256='2056768ab589308840940c2648306276f6da6ef2a0ccf7101e284b5e0fc263b7' ;; \
			'node_exporter-1.10.0.linux-ppc64.tar.gz') sha256='da336c6c81b9c4f70dee82b1f10914bf6cc6856ffdf43149ce9455f7be9e60d9' ;; \
			'node_exporter-1.10.0.linux-ppc64le.tar.gz') sha256='63c9dc301abb4a2489d87abce583b6ea1896f1d27ea9b2400d4e84551a2da4f0' ;; \
			'node_exporter-1.10.0.linux-riscv64.tar.gz') sha256='d00cba66fb7bbd18f46912b7428738072993ea69041c077050de0eee4cf30866' ;; \
			'node_exporter-1.10.0.linux-s390x.tar.gz') sha256='0e2054167ef07cb72b5e34c4ef0a6bcc3c72fe79fa8e034bd6174980206fae3f' ;; \
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
