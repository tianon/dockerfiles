#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.9.0

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
			'node_exporter-1.9.0.linux-386.tar.gz') sha256='cadc75cb4d362a23d62494f0eea2fc98c0265d28f8a799e862919d402f4c9427' ;; \
			'node_exporter-1.9.0.linux-amd64.tar.gz') sha256='e7b65ea30eec77180487d518081d3dcb121b975f6d95f1866dfb9156c5b24075' ;; \
			'node_exporter-1.9.0.linux-arm64.tar.gz') sha256='5314fae1efff19abf807cfc8bd7dadbd47a35565c1043c236ffb0689dc15ef4f' ;; \
			'node_exporter-1.9.0.linux-armv5.tar.gz') sha256='1a16210cf53df8fa06a503932274d0b3d14fe1bc7fc11bcffa008f0a047a5d86' ;; \
			'node_exporter-1.9.0.linux-armv6.tar.gz') sha256='9681bac77494b5d4f002e380e0fea5d872012b660912fee10e85e480e56b82a3' ;; \
			'node_exporter-1.9.0.linux-armv7.tar.gz') sha256='27ff7b105fd4cfc58c2762a6387d93e62eb55473cb5111eb5feb7086c60ef05f' ;; \
			'node_exporter-1.9.0.linux-mips.tar.gz') sha256='0bc2b135a67b6a07a16c06bdb1df7f085b04dd38d89dcce721556368c382c7b8' ;; \
			'node_exporter-1.9.0.linux-mips64.tar.gz') sha256='60909d6f2c3b04352cc7b7fbf9ff3fbd6dfb06e22ac4ac25014565565e54c84d' ;; \
			'node_exporter-1.9.0.linux-mips64le.tar.gz') sha256='b0629cd99ce811fee6b040c3564f8d8a8ddba43d9490690322426d50e1d003a3' ;; \
			'node_exporter-1.9.0.linux-mipsle.tar.gz') sha256='e6f1e45c812fdbee8b7d3c7e1518ccd16f70bdb577c2b8d92b118e4d92cf5bf6' ;; \
			'node_exporter-1.9.0.linux-ppc64.tar.gz') sha256='e999e6bd93ffb1c7fc2fa699fef0f397578342a9130cb04df4610517f7980075' ;; \
			'node_exporter-1.9.0.linux-ppc64le.tar.gz') sha256='4049266cdc9f548b65f6e2620daf0b12582c47ff2c1d4db29b55db082d73be43' ;; \
			'node_exporter-1.9.0.linux-riscv64.tar.gz') sha256='84ce1b364ba134539b3324a69e320a3e9b7f72bf1098e9f6789167cc01c2be80' ;; \
			'node_exporter-1.9.0.linux-s390x.tar.gz') sha256='089d2c2f87b4d716dd5ff006b89ab4424e7917f67830a8dd580d528f1d99ca58' ;; \
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
