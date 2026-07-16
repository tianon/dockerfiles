#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.12.1

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
			'node_exporter-1.12.1.linux-386.tar.gz') sha256='1d3522a81739f49d05f44bea692a0abe83b99305c70b36f5472d77946b9ba0db' ;; \
			'node_exporter-1.12.1.linux-amd64.tar.gz') sha256='b51d8a76aa2a9156a55d501aca6276fae09e262259a5e4e831d2c2222f084e63' ;; \
			'node_exporter-1.12.1.linux-arm64.tar.gz') sha256='ad35b605f9954b9f1ffddf5ba054bdc5a98d790b9eae5291e1eeb83f1ecbd0e7' ;; \
			'node_exporter-1.12.1.linux-armv5.tar.gz') sha256='7dc9ba80bcf605be533630a2d80d4df8490829354206bb33c799889f82009a6b' ;; \
			'node_exporter-1.12.1.linux-armv6.tar.gz') sha256='798ecfc90133ab1ec6ec490112895f7331d8b365aa162cb077177e8bdf5a7a41' ;; \
			'node_exporter-1.12.1.linux-armv7.tar.gz') sha256='ae3d72fbf77f9ebed553c24465310e0880383f45d3d1566357ce7a31a997acb2' ;; \
			'node_exporter-1.12.1.linux-mips.tar.gz') sha256='de3ddee6da029fef764671fa7f74c2ad5994d3433f7c46ab5bfd1d5ccfc8541c' ;; \
			'node_exporter-1.12.1.linux-mips64.tar.gz') sha256='6665c48e5e12a57e6c5127f496aeb51f6b330b5b3ba550c0fcbb24a5fecdae2c' ;; \
			'node_exporter-1.12.1.linux-mips64le.tar.gz') sha256='8f4ade550c5a2b96aa4e5e16d12f2d5cf2f6ab2275ae65df29d57a818401ea80' ;; \
			'node_exporter-1.12.1.linux-mipsle.tar.gz') sha256='8060aa6baac393c97601dc79a53aa2c5a93c8946321a836534543e26cb8198bf' ;; \
			'node_exporter-1.12.1.linux-ppc64.tar.gz') sha256='47bf8f94ce82d12968ccc396b1f7c656bae5509f83805e8a9bf6b8203f25aa70' ;; \
			'node_exporter-1.12.1.linux-ppc64le.tar.gz') sha256='0465fa56bcb1eeae2f817aa6794ffe8ea8b1d3c96ecb50ea71f248e725bead6c' ;; \
			'node_exporter-1.12.1.linux-riscv64.tar.gz') sha256='94f2332ec13f28e9aab2a5e9a12cc64b5cea1c5328e617754b3479e6ddf75b55' ;; \
			'node_exporter-1.12.1.linux-s390x.tar.gz') sha256='eec3243a0354309a5a11180b864f203616a693c1106858e58a6c24e01205e94b' ;; \
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
