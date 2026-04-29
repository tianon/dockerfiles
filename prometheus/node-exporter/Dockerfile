#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.11.1

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
			'node_exporter-1.11.1.linux-386.tar.gz') sha256='4df4ec0dca5bc061c59181cfedcd8887cb5df9c710db3c4038bc51923414bc5d' ;; \
			'node_exporter-1.11.1.linux-amd64.tar.gz') sha256='9f5ea48e5bc7b656f8a91a32e7d7deb89f70f73dabd0d974418aca15f37d6810' ;; \
			'node_exporter-1.11.1.linux-arm64.tar.gz') sha256='ba1886efbd76cb96b0087c695ea8d1b9cb6e8aa946c996d744e9ee16c8e3591a' ;; \
			'node_exporter-1.11.1.linux-armv5.tar.gz') sha256='2466a4f153357ea98557bfa90dfa1aa81c39393f9bbe24bc28032509d973cffc' ;; \
			'node_exporter-1.11.1.linux-armv6.tar.gz') sha256='95b1707218564e11a88bf78eb924c8af82038a0436171c626234399fec866ec3' ;; \
			'node_exporter-1.11.1.linux-armv7.tar.gz') sha256='661c662e566d5c68950d63f7dfd1ec46ba28858f91aeba220c32baa1d3ad7b33' ;; \
			'node_exporter-1.11.1.linux-mips.tar.gz') sha256='97cb0ecb2ddbf9f13c04cad702f2702a1a6c6e622c1f2345653a78d9be1038f8' ;; \
			'node_exporter-1.11.1.linux-mips64.tar.gz') sha256='206c5a16ae4526fdd158966df2a7eef44ba95c4b057ee6da2ae4e97cd94c3299' ;; \
			'node_exporter-1.11.1.linux-mips64le.tar.gz') sha256='fc09063042d2de2715c64ad8316d582ac2e6e626053276ca907eab9a30c80cc9' ;; \
			'node_exporter-1.11.1.linux-mipsle.tar.gz') sha256='156bb3da8c6f9f5a9e8afcc7721b89c14528c5066bc8080eb6fe8c3e7b04d914' ;; \
			'node_exporter-1.11.1.linux-ppc64.tar.gz') sha256='c8077cb55861803ecd7c419f90784296bf440a04818eeceaa00e0abbda34728b' ;; \
			'node_exporter-1.11.1.linux-ppc64le.tar.gz') sha256='c2ad3a2f8715b4b4ac2b0dcbbe7e88e5007ea85de2593ac206f2d673d296749a' ;; \
			'node_exporter-1.11.1.linux-riscv64.tar.gz') sha256='8d73447c47488a94f7eba467838c815ea7dceb449c75b1b8e91fa6dc3e0e364e' ;; \
			'node_exporter-1.11.1.linux-s390x.tar.gz') sha256='304c106b3e96b39c950075243cc1506964b98307554823c0f632c837a2ecac51' ;; \
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
