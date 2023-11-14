#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.7.0

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
			'node_exporter-1.7.0.linux-386.tar.gz') sha256='fa662462d5bf69895b64a1efaabfab2ce0b6fa8962e960cb6a5277fa394d5c2d' ;; \
			'node_exporter-1.7.0.linux-amd64.tar.gz') sha256='a550cd5c05f760b7934a2d0afad66d2e92e681482f5f57a917465b1fba3b02a6' ;; \
			'node_exporter-1.7.0.linux-arm64.tar.gz') sha256='e386c7b53bc130eaf5e74da28efc6b444857b77df8070537be52678aefd34d96' ;; \
			'node_exporter-1.7.0.linux-armv5.tar.gz') sha256='5745e8f5c24efbefbe8a26a9407e3dbc52558f56f1150d7ea2aa06fc166a08c4' ;; \
			'node_exporter-1.7.0.linux-armv6.tar.gz') sha256='0a3c5578be8dfca56dc5cce7bc788fb4625c64a8e0209ac779660fae9a6331db' ;; \
			'node_exporter-1.7.0.linux-armv7.tar.gz') sha256='2f8df32a8926c6368b3e0815fe900eb5cde1096bf0750e3d1e79f2f35b0e274d' ;; \
			'node_exporter-1.7.0.linux-mips.tar.gz') sha256='73df12e39a4ac1fe52b4967b6895d43d9dd826cf7c8d33857b33d56ae1c5a612' ;; \
			'node_exporter-1.7.0.linux-mips64.tar.gz') sha256='8908900967a9a3b8380573dadf994ca02abf823b866ed2ae9dbfa030d7b48510' ;; \
			'node_exporter-1.7.0.linux-mips64le.tar.gz') sha256='4192468c3337f363b928d24ab3505c7ff513eae390c91ad49e1503ba8cd9f948' ;; \
			'node_exporter-1.7.0.linux-mipsle.tar.gz') sha256='be29eccd784cc489916295f3bbe2c9029c918090c43ee6f0220c401102ac6a4f' ;; \
			'node_exporter-1.7.0.linux-ppc64.tar.gz') sha256='473ebeb73d73c8982005a3252fd36889230d4ca9b878bd0cd336d5e585e54d1a' ;; \
			'node_exporter-1.7.0.linux-ppc64le.tar.gz') sha256='c4f8151f7f6c530587c6e5b9879c5765daa195432d822a3531bd2bcadd3393a2' ;; \
			'node_exporter-1.7.0.linux-riscv64.tar.gz') sha256='ba2d97e9b07d4ba0e5a264b436a2fafcf8aaa9d2fc44e47eb57faf58c2142302' ;; \
			'node_exporter-1.7.0.linux-s390x.tar.gz') sha256='aeda68884918f10b135b76bbcd4977cb7a1bb3c4c98a8551f8d2183bafdd9264' ;; \
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
