#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 3.7.3

RUN set -ex; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) promArch='arm64'   ;; \
		armhf)   promArch='armv6'   ;; \
		armv7)   promArch='armv7'   ;; \
		ppc64le) promArch='ppc64le' ;; \
		riscv64) promArch='riscv64' ;; \
		s390x)   promArch='s390x'   ;; \
		x86)     promArch='386'     ;; \
		x86_64)  promArch='amd64'   ;; \
		*) echo >&2 "error: unsupported arch: $apkArch"; exit 1 ;; \
	esac; \
	\
	filename="prometheus-${PROMETHEUS_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'prometheus-3.7.3.linux-386.tar.gz') sha256='2ee92349eb9e82ffd9a4d0c1569f8e71021334c8a4ce9020fe7010cf54c6cb4f' ;; \
		'prometheus-3.7.3.linux-amd64.tar.gz') sha256='fc9e5da126817438cf2820d9a7206c75e3122802ba8d20add3a6219a59ca6913' ;; \
		'prometheus-3.7.3.linux-arm64.tar.gz') sha256='6af448fa4f3640eb9bd51ce71575689a1ef79843b1cf08ef1fcc7ff9a1928bfd' ;; \
		'prometheus-3.7.3.linux-armv5.tar.gz') sha256='d4a9501c65e1de97e52fd12c222ad6234e1366c52538e640c08af5ab2c7cc1c5' ;; \
		'prometheus-3.7.3.linux-armv6.tar.gz') sha256='e38b39977cac58650b1fa556a50f118a112e4b8efb590b7102bd1c94ac50ce90' ;; \
		'prometheus-3.7.3.linux-armv7.tar.gz') sha256='238015d0977d14ceaf0196a38875708261d5b5bf029d99e717569538990eda34' ;; \
		'prometheus-3.7.3.linux-mips.tar.gz') sha256='65c155fb025b08049c7feb00f3d5d4d446b32801559e1344bccc25667cf680d0' ;; \
		'prometheus-3.7.3.linux-mips64.tar.gz') sha256='f62cf03ee8852e39528bbbd6baca5dc60cabb566505bd83c1accbb4c2dc71692' ;; \
		'prometheus-3.7.3.linux-mips64le.tar.gz') sha256='db33c5d4e46ef9091015ed67fac28b1cfa927c1623fdd1e5bde02e03592eccfc' ;; \
		'prometheus-3.7.3.linux-mipsle.tar.gz') sha256='2ab14eeddf4e3a6d00c52b6cf40e0c19de4308cfa945c9254f487d73e7c372ce' ;; \
		'prometheus-3.7.3.linux-ppc64.tar.gz') sha256='1ede1e685ccaf933fa50dd3020ba400b7d3e481d20e1751dbf0286e9a76605d4' ;; \
		'prometheus-3.7.3.linux-ppc64le.tar.gz') sha256='da9427cf0d7749f4701c3d63f2a954657cd7b8dc9f8905b354492ff7ef495d5a' ;; \
		'prometheus-3.7.3.linux-riscv64.tar.gz') sha256='dd804364067e0e87af91cb49db06f37acbba5a1b7567f6e12201731aba5b089d' ;; \
		'prometheus-3.7.3.linux-s390x.tar.gz') sha256='285c1086213f20ef481111372aaa63292208d5d6a741d01bb9390a8b4aa4edfb' ;; \
		*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
	esac; \
	wget -O /tmp/prom.tar.gz "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/$filename"; \
	echo "$sha256 */tmp/prom.tar.gz" | sha256sum -c -; \
	\
	tar \
		--extract \
		--file /tmp/prom.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/prom.tar.gz; \
	\
	prometheus --version

VOLUME /opt/prometheus/data
EXPOSE 9090

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
