#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 2.53.1

RUN set -ex; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) promArch='arm64'   ;; \
		armhf)   promArch='armv6'   ;; \
		armv7)   promArch='armv7'   ;; \
		ppc64le) promArch='ppc64le' ;; \
		s390x)   promArch='s390x'   ;; \
		x86)     promArch='386'     ;; \
		x86_64)  promArch='amd64'   ;; \
		*) echo >&2 "error: unsupported arch: $apkArch"; exit 1 ;; \
	esac; \
	\
	filename="prometheus-${PROMETHEUS_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'prometheus-2.53.1.linux-386.tar.gz') sha256='b0fb6e84d15a5af9bf69b4ff519dff64f9bb1714ec6eddddc1917bae80a67c58' ;; \
		'prometheus-2.53.1.linux-amd64.tar.gz') sha256='2234aa0f66d9f9b854144f6faaaed72a316df7a680d9dad7cb48e49a6fa5332c' ;; \
		'prometheus-2.53.1.linux-arm64.tar.gz') sha256='a7f28c83c3c943b953a9d00860bd3f2422464fb7c27a3c4037ef1ce2a41592b5' ;; \
		'prometheus-2.53.1.linux-armv5.tar.gz') sha256='a3180004263aa96276e280122febed1b8b3056bd5e9afdcfdc86ba94bf5974f8' ;; \
		'prometheus-2.53.1.linux-armv6.tar.gz') sha256='b243c019d8a6df3f13808e0397d09e90db40b3648ef79eeefa94bf860d786b0b' ;; \
		'prometheus-2.53.1.linux-armv7.tar.gz') sha256='d30210c364455730a85ea4109747462f22631c67d7fec6437327cee9766845d8' ;; \
		'prometheus-2.53.1.linux-mips.tar.gz') sha256='2036d0ae2f9fa3c6ddcb242656afbab6680b9fe10c8f429b61700f21093ca7d8' ;; \
		'prometheus-2.53.1.linux-mips64.tar.gz') sha256='d451dce6dbb0d08d3d6089d8928b30d188516892a3df47207d4dcb60acfafdc6' ;; \
		'prometheus-2.53.1.linux-mips64le.tar.gz') sha256='4732b1f7fcd0e385b74c535a08172b277b6b9b3efa7adcbacc8503a5187eb059' ;; \
		'prometheus-2.53.1.linux-mipsle.tar.gz') sha256='0a7e20b18617443f51c04e0ba64ee9f6270c31b4d6461504bf979edf034f53b4' ;; \
		'prometheus-2.53.1.linux-ppc64.tar.gz') sha256='01237e645d279183ab8bc7390e102779bbc72ffafc2d11a8417a62af7f63083e' ;; \
		'prometheus-2.53.1.linux-ppc64le.tar.gz') sha256='6cc285f796a1eccd8f36b930a143c90d4b1411ff5b3fad29cdfb46b2ff4482cd' ;; \
		'prometheus-2.53.1.linux-riscv64.tar.gz') sha256='663d15b16438476c66b1678f52665d98f2be2a4f1c93ea68585b76cd6f0bbeed' ;; \
		'prometheus-2.53.1.linux-s390x.tar.gz') sha256='9cc0f7733b07deda1a8e88661dfd92e7112b6ffe772d16cf7a5a426ebbc8419a' ;; \
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
