#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

# https://github.com/prometheus/node_exporter/releases
ENV NODE_EXPORTER_VERSION 1.8.2

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
			'node_exporter-1.8.2.linux-386.tar.gz') sha256='293ab667ef78eb38915ff5ef019093fb15c7887f072ea70656083d1a17d61858' ;; \
			'node_exporter-1.8.2.linux-amd64.tar.gz') sha256='6809dd0b3ec45fd6e992c19071d6b5253aed3ead7bf0686885a51d85c6643c66' ;; \
			'node_exporter-1.8.2.linux-arm64.tar.gz') sha256='627382b9723c642411c33f48861134ebe893e70a63bcc8b3fc0619cd0bfac4be' ;; \
			'node_exporter-1.8.2.linux-armv5.tar.gz') sha256='1dda7ebd2e4df48f1c579b5e5d4191b5b8a20b9cb012f99f8fc72ccb31e2e679' ;; \
			'node_exporter-1.8.2.linux-armv6.tar.gz') sha256='995a0c14766baec620e58f0c222186f722cc000c8fc3c9d8e1b6e7bed3e91744' ;; \
			'node_exporter-1.8.2.linux-armv7.tar.gz') sha256='0fb88e682d055a70a8597504874b0a76d1df6a8a511f3d7cb1d48c7db84a2d2a' ;; \
			'node_exporter-1.8.2.linux-mips.tar.gz') sha256='71ca7e0a5113bba4edf9852ee17ee6544ca21d16c6c104fcdb6cecc5ce4af5ac' ;; \
			'node_exporter-1.8.2.linux-mips64.tar.gz') sha256='0080c5564c6844f11e2ad39864993407bace78a458d995397e0c419b1d460ec7' ;; \
			'node_exporter-1.8.2.linux-mips64le.tar.gz') sha256='40d6280c270b0e204bbfe47ec0536273395afbb2bdbbe199ac87b684b0d01844' ;; \
			'node_exporter-1.8.2.linux-mipsle.tar.gz') sha256='210379a276654c60d0090f15cb3e022bec9b46b3a380741fb43cd779020eed4c' ;; \
			'node_exporter-1.8.2.linux-ppc64.tar.gz') sha256='bb56e72a6ce64173b9b8e7af3d172bb3775804f421e50e1c2954a822e7f221d2' ;; \
			'node_exporter-1.8.2.linux-ppc64le.tar.gz') sha256='9515f2472fcec185d55dda4864c094188b4169e1b79704e1806b358b8b439f64' ;; \
			'node_exporter-1.8.2.linux-riscv64.tar.gz') sha256='2cca99fb908e24f33b4395f5cdcd21cbe5d438d2b193d92a9161283e4ede6d55' ;; \
			'node_exporter-1.8.2.linux-s390x.tar.gz') sha256='971481f06a985e9fcaee9bcd8da99a830d5b9e5f21e5225694de7e23401327c4' ;; \
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
