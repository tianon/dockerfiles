#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.10.2

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
			'node_exporter-1.10.2.linux-386.tar.gz') sha256='0220ed76581bb1e25c0c6416338ea254c7a259f17de50fc74cdb0abd74148bc7' ;; \
			'node_exporter-1.10.2.linux-amd64.tar.gz') sha256='c46e5b6f53948477ff3a19d97c58307394a29fe64a01905646f026ddc32cb65b' ;; \
			'node_exporter-1.10.2.linux-arm64.tar.gz') sha256='de69ec8341c8068b7c8e4cfe3eb85065d24d984a3b33007f575d307d13eb89a6' ;; \
			'node_exporter-1.10.2.linux-armv5.tar.gz') sha256='c9311911eb21c9bae72e5180b25c8815d6eafcc13396a417545017da61850ba2' ;; \
			'node_exporter-1.10.2.linux-armv6.tar.gz') sha256='5d62e4cf6319a9d64a5d703b5c9ddf76e0bfb60bec484cfab728b172a2bb003a' ;; \
			'node_exporter-1.10.2.linux-armv7.tar.gz') sha256='5c56faa68b8f5f45cf3b2124190ce9f053b3270443baa379d6245e2173209a08' ;; \
			'node_exporter-1.10.2.linux-mips.tar.gz') sha256='dd3ed2ba8bd000e3ba1e9e130845e6defa167288609c9e2c589c28ef17969423' ;; \
			'node_exporter-1.10.2.linux-mips64.tar.gz') sha256='7d6cb7c25919c7624504c10f1b4904b364a7f7f447c510502de7b5c6d4fe2931' ;; \
			'node_exporter-1.10.2.linux-mips64le.tar.gz') sha256='034a7b115b2e5eed621bc8eb870d30fe844094d694dd4d7b71222233adb03d31' ;; \
			'node_exporter-1.10.2.linux-mipsle.tar.gz') sha256='0c870c4612a4a6a16857ff585fb490e423a9b8244fcdfaf34043bb5589f56d91' ;; \
			'node_exporter-1.10.2.linux-ppc64.tar.gz') sha256='631f1abd306f157e9cfafdd12038672f92fe613db03e8a8627015fa36c380757' ;; \
			'node_exporter-1.10.2.linux-ppc64le.tar.gz') sha256='2ec66b407baeb3930b13a3aac661fe33525293a2870204dd923d5da1c7c85d25' ;; \
			'node_exporter-1.10.2.linux-riscv64.tar.gz') sha256='ae8c457f710fbefc664db4c8b0f2053ce6fbe19fad8cb032484f7d083846dd31' ;; \
			'node_exporter-1.10.2.linux-s390x.tar.gz') sha256='3ad4b412254769ab5128bc7211a324cd6e0643540b63351fd6b61830f00402de' ;; \
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
