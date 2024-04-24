#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.8.0

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
			'node_exporter-1.8.0.linux-386.tar.gz') sha256='128b4125d26f0927fcd5c14595d683a32b5610826bde55521ad74d5b95da301c' ;; \
			'node_exporter-1.8.0.linux-amd64.tar.gz') sha256='c184e5dd98d518ac468339a9e073c233f777e0948a18862dd88e3f1bdcdf1438' ;; \
			'node_exporter-1.8.0.linux-arm64.tar.gz') sha256='a6d1924f6ec46cdacbeeb24b23af6b41fff0f1dd14f5cb19d7c1379c9c822146' ;; \
			'node_exporter-1.8.0.linux-armv5.tar.gz') sha256='170315589f39f85c6ee827fd6b0cdc7e8f4caff4c59a40113ba6fdf70dcb9ba4' ;; \
			'node_exporter-1.8.0.linux-armv6.tar.gz') sha256='d8246bf46ffae344bff1ec2563daba802df7a297cc72ed0488bfe0552dccac2a' ;; \
			'node_exporter-1.8.0.linux-armv7.tar.gz') sha256='5668d6eefbb851f38ee89c3ab0894ef68c35cecea8bb0cb368fa19091518cc01' ;; \
			'node_exporter-1.8.0.linux-mips.tar.gz') sha256='c95d65ddab70325a26e6cc682e9b7b16d721566c887d464e6c095df24cf4b4e2' ;; \
			'node_exporter-1.8.0.linux-mips64.tar.gz') sha256='913f3b0035e906547cd1899e9a80eaeb1f8733a435e4093876b2a7a293254d46' ;; \
			'node_exporter-1.8.0.linux-mips64le.tar.gz') sha256='565645d81a8a73c5427c2a8a356ad7c88edf756e4cee9221211336e7f45ad64d' ;; \
			'node_exporter-1.8.0.linux-mipsle.tar.gz') sha256='0749b438e58e1e306e109ba05316c26cedc441ebebf2a7a99f9d583395235542' ;; \
			'node_exporter-1.8.0.linux-ppc64.tar.gz') sha256='9ea578d57197dabc60440acae8d9e17fbb0b6097788b87d73e033f7a637a7f9b' ;; \
			'node_exporter-1.8.0.linux-ppc64le.tar.gz') sha256='5b6f95973efef99c8767a5bd70d7e6f7a779ea66205a47cbabaec657abb170e6' ;; \
			'node_exporter-1.8.0.linux-riscv64.tar.gz') sha256='7c3c49a1a033577a32af69250c20d50773d3b32d3c67aab57b00f06f9e48e9f2' ;; \
			'node_exporter-1.8.0.linux-s390x.tar.gz') sha256='0869b4e5587c7cb84ade6c697d2b42955d34efe916cb70f930037a2e3813bc1a' ;; \
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
