#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.13.0

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
			'node_exporter-1.13.0.linux-386.tar.gz') sha256='e174de418cb6592415545346f8e5db894daf6a1df15ff59ab44e89e2b5532869' ;; \
			'node_exporter-1.13.0.linux-amd64.tar.gz') sha256='f6a6c72ee04fd6537efede3900ea45385eeade513c99de60d607d4b1611f8e6e' ;; \
			'node_exporter-1.13.0.linux-arm64.tar.gz') sha256='01f65e7ab3e1f7c04e167fbe097968609eebc9d54cbe523b71d101b830f5d54a' ;; \
			'node_exporter-1.13.0.linux-armv5.tar.gz') sha256='3022f2af7834a2ca07b5b258f1d3dcbbb3935e67946df6a0642d6a96809fa690' ;; \
			'node_exporter-1.13.0.linux-armv6.tar.gz') sha256='0e94703bbb0668ceaa3157a6a4f768cc6e569891bffe6861bbd8075dae396e1c' ;; \
			'node_exporter-1.13.0.linux-armv7.tar.gz') sha256='911c2a28799a8b592815a9ed8066a4dea56b34396524fcb10e4b9f5e6c1e05ef' ;; \
			'node_exporter-1.13.0.linux-mips.tar.gz') sha256='8ac2214c874a08c45d35a8673c700cbb50e335eb5841605194c6602c3f8f2e8b' ;; \
			'node_exporter-1.13.0.linux-mips64.tar.gz') sha256='b8e7afd6e7afd0a7bd4327be5bb9849f661d26118b1b195421c8bc11d1f61559' ;; \
			'node_exporter-1.13.0.linux-mips64le.tar.gz') sha256='897754c44ef849957258ec371f0673c49ae16e171b3da9f71f2e76339911842e' ;; \
			'node_exporter-1.13.0.linux-mipsle.tar.gz') sha256='5b072bfa1feadaf8ecfe7f038403cb320d86c8a163333bfa2c4e6375c704cc71' ;; \
			'node_exporter-1.13.0.linux-ppc64.tar.gz') sha256='c6e26eeead2d940710b7eb6d5bacd69c055f4b225078d4207fa965142571136c' ;; \
			'node_exporter-1.13.0.linux-ppc64le.tar.gz') sha256='78d85b711f930395edb9acda40bdd1a4a9409792d7d157d19a7875cf4cbb1668' ;; \
			'node_exporter-1.13.0.linux-riscv64.tar.gz') sha256='474af49b12567428edbfc229152656d8089d4012a3b2e4ca3ac66a43c308f3ed' ;; \
			'node_exporter-1.13.0.linux-s390x.tar.gz') sha256='74c4b03acb63c228c09c7fe57c61418922a201f05762205b93a1d38ef3c957c8' ;; \
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
