#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.9.1

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
			'node_exporter-1.9.1.linux-386.tar.gz') sha256='42c8a3853d7ab50b1d9fd1181411452aeefe70eec44923e808c44fb4169e3205' ;; \
			'node_exporter-1.9.1.linux-amd64.tar.gz') sha256='becb950ee80daa8ae7331d77966d94a611af79ad0d3307380907e0ec08f5b4e8' ;; \
			'node_exporter-1.9.1.linux-arm64.tar.gz') sha256='848f139986f63232ced83babe3cad1679efdbb26c694737edc1f4fbd27b96203' ;; \
			'node_exporter-1.9.1.linux-armv5.tar.gz') sha256='31350f2cf21916e0602b59e7d03b870e8b9528eec4bbd88fa2e8ce7855b063c2' ;; \
			'node_exporter-1.9.1.linux-armv6.tar.gz') sha256='3fb1de42b4dfd72147574d1c0c3b24077b49c570b71cecb698867f645cd3d8f6' ;; \
			'node_exporter-1.9.1.linux-armv7.tar.gz') sha256='f04c95c9c474516b06ab10e34a663992ccad4c9185596e404f02790ec23d83d9' ;; \
			'node_exporter-1.9.1.linux-mips.tar.gz') sha256='b2d7789a9750eb9bc79702e5a2c52bfba24c5449fb255cd7aeae781a01bed09f' ;; \
			'node_exporter-1.9.1.linux-mips64.tar.gz') sha256='c647dbcb93a7e7d28b60f4d28e6ce7cd6bfd49e21756e03d4862c236095782b4' ;; \
			'node_exporter-1.9.1.linux-mips64le.tar.gz') sha256='729010e4cdc8d345869c6f93e5a4f092f64237be04ad7faa91a077aa6a73a970' ;; \
			'node_exporter-1.9.1.linux-mipsle.tar.gz') sha256='326b5bef89542456ba7916783b65c8d1aef60ed38baad4886d0f001d3d265c56' ;; \
			'node_exporter-1.9.1.linux-ppc64.tar.gz') sha256='d1a1326aa253ac934cbc692a9beaa8cb92913f4593ec7444d6837e9a12752836' ;; \
			'node_exporter-1.9.1.linux-ppc64le.tar.gz') sha256='ebb869058e7730f2e3e3e96be873d39951b2353f188dcdb3e6f1a829ffa2ad00' ;; \
			'node_exporter-1.9.1.linux-riscv64.tar.gz') sha256='93b079535e60785fc457f9a745c87812ac87d8febc3b044af31931fe1f3b40c9' ;; \
			'node_exporter-1.9.1.linux-s390x.tar.gz') sha256='80eddf59704149a0beb545be7f871b30ee0beaa24bd4ecf7da1ab738bee6985c' ;; \
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
