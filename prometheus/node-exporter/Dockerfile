#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.8.1

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
			'node_exporter-1.8.1.linux-386.tar.gz') sha256='22722fedb554fcf6ac4758b3f0044c76d62c41def81fa093a6e49cd57e54bb39' ;; \
			'node_exporter-1.8.1.linux-amd64.tar.gz') sha256='fbadb376afa7c883f87f70795700a8a200f7fd45412532cc1938a24d41078011' ;; \
			'node_exporter-1.8.1.linux-arm64.tar.gz') sha256='3b5c4765e429d73d0ec83fcd14af39087025e1f7073422fa24be8f4fa3d3bb96' ;; \
			'node_exporter-1.8.1.linux-armv5.tar.gz') sha256='ca9f589ead99d36d8d91ca380b76bef05983880a83da1c4c52dff804854fac62' ;; \
			'node_exporter-1.8.1.linux-armv6.tar.gz') sha256='142dc39284e20e3c02ddc6f478df1265dafad1c6725b4bea6857142c3b20b571' ;; \
			'node_exporter-1.8.1.linux-armv7.tar.gz') sha256='28a06a32ac3dffb5843b4183054201c9ae3543fc1a39af6a83485f6d6590ec75' ;; \
			'node_exporter-1.8.1.linux-mips.tar.gz') sha256='1bcf112a8ba343f02e5644577d7dfec4a5ab03f4ca525e4ed2e2134948da39fe' ;; \
			'node_exporter-1.8.1.linux-mips64.tar.gz') sha256='65f91df3d1517a39675aab866f413114f4ba9d03ed11fe299893d66ce47ff5ab' ;; \
			'node_exporter-1.8.1.linux-mips64le.tar.gz') sha256='ec30679948b3046c6fa4660ffcba3056b82450b1a104d40e920c17a7571694b9' ;; \
			'node_exporter-1.8.1.linux-mipsle.tar.gz') sha256='a402be369fefba4c5528298503568e7f4aaf5d9e59122c87a01bfbaecb70c0a8' ;; \
			'node_exporter-1.8.1.linux-ppc64.tar.gz') sha256='8eacfeb016a0b5b94190f25b907bf6701ffe4014ec575293df99945c0a5e249f' ;; \
			'node_exporter-1.8.1.linux-ppc64le.tar.gz') sha256='5c5f1c6de0d170560ce229e15d262c98b8d696cc0787661d5a6169dc70fcaa57' ;; \
			'node_exporter-1.8.1.linux-riscv64.tar.gz') sha256='a75a0324d09d5ed961cf93bcf678db4e32ae6d3f3b7c0ba852a0665090eb06fc' ;; \
			'node_exporter-1.8.1.linux-s390x.tar.gz') sha256='29af55427ac0aa7820393a3396f986a272fdf273caeed93901480a39540de41a' ;; \
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
