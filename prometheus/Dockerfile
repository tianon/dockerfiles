#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.21

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 3.3.0

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
		'prometheus-3.3.0.linux-386.tar.gz') sha256='a14ef93d3a56d2a265e05d85e53f7f74d7496f7d4cbafb07c759a2b21dd91e18' ;; \
		'prometheus-3.3.0.linux-amd64.tar.gz') sha256='cba98e0e17edab9f745122d92072e7de59440da9c975c51ecf982b0b2d630787' ;; \
		'prometheus-3.3.0.linux-arm64.tar.gz') sha256='ac84be2c78dad8c9b808a51dcded7009c7c1ef382675a777ce5fd729535178cd' ;; \
		'prometheus-3.3.0.linux-armv5.tar.gz') sha256='604b2f6a4c4852e4c61d22cc1684a9e4ae26d2bb0d1036a93c50f8b2aa1d348c' ;; \
		'prometheus-3.3.0.linux-armv6.tar.gz') sha256='a446f60fcff891037aa07217ee0d2d69a45128ba1b50ea0c560bb84743614b82' ;; \
		'prometheus-3.3.0.linux-armv7.tar.gz') sha256='0ac16cdd6920316305cbf5782f2c664464e7398a5ea51abd2fac34a7e3c856f0' ;; \
		'prometheus-3.3.0.linux-mips.tar.gz') sha256='0a607fc70eeb48e38747adf763926608e3b7dd70612db1459e4ab0da654f28c3' ;; \
		'prometheus-3.3.0.linux-mips64.tar.gz') sha256='a55f73a5aeda3ffab3d2af6fea195d4885793ff268a7be6af451aca2f10ef146' ;; \
		'prometheus-3.3.0.linux-mips64le.tar.gz') sha256='973da90d053d95685501761e96c2af69598f19019761db0ff2120baa07021aa8' ;; \
		'prometheus-3.3.0.linux-mipsle.tar.gz') sha256='a1e147fa3939fcf0063f524e84995e7e02829b38d9a561e763e91b17cde3ef5f' ;; \
		'prometheus-3.3.0.linux-ppc64.tar.gz') sha256='282a757244c19f6158407af12f0dc77a2f59025d7b337b190bce03abb2ed1a5f' ;; \
		'prometheus-3.3.0.linux-ppc64le.tar.gz') sha256='03d76572ddfa9478fe71ca79260db7039f20242b85f9fc1ebe23d110dd3fa44d' ;; \
		'prometheus-3.3.0.linux-riscv64.tar.gz') sha256='b3a477e571ce18515bbf3d18920996c45eb928890a208a682c6801396dd3bc75' ;; \
		'prometheus-3.3.0.linux-s390x.tar.gz') sha256='4013a5c7e526c8c46e57476fe9b73c7e3ccff538ecc3310c0105190e194ef100' ;; \
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
