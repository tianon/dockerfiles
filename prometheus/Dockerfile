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
ENV PROMETHEUS_VERSION 2.53.0

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
		'prometheus-2.53.0.linux-386.tar.gz') sha256='8eaca90bd5da21a99559c4fcdf8026d858eea11dcd5b5fc5f76939fb0f11ce77' ;; \
		'prometheus-2.53.0.linux-amd64.tar.gz') sha256='d9900a11e3c89261e6416e3c9989858bad7b206af8b6838dfe9a5392d8ddc60d' ;; \
		'prometheus-2.53.0.linux-arm64.tar.gz') sha256='f3fb3c12db28155a791eba57f293c899ad753677a5aa8c327a80483b23ce98c6' ;; \
		'prometheus-2.53.0.linux-armv5.tar.gz') sha256='cbb96041bc8fc8a22891966ec4ce52844bbcb70e34e6bcf24901b82e4c0c5bb1' ;; \
		'prometheus-2.53.0.linux-armv6.tar.gz') sha256='6122db083861027526b2aaaf6cc5324f22c10936657082fb0a99830053e8855a' ;; \
		'prometheus-2.53.0.linux-armv7.tar.gz') sha256='aabe658a02b7dd12c220d895dd64e7d4b2a5ab7a303cfb51e1767447d31764b4' ;; \
		'prometheus-2.53.0.linux-mips.tar.gz') sha256='6e30c64d513002f1726524d8d49c2f7e6b5d0b7da6e76c0c37e1992d5aa4c9b1' ;; \
		'prometheus-2.53.0.linux-mips64.tar.gz') sha256='dc5c78af2d961fa6f817fb462b35606b4b499e64d1cef6221631e5e216c8718c' ;; \
		'prometheus-2.53.0.linux-mips64le.tar.gz') sha256='7da9460a487bc95d392c940393b17f7d919c7db70fee38eb59b8f4eab3d2b1e1' ;; \
		'prometheus-2.53.0.linux-mipsle.tar.gz') sha256='ebf9f2e2647d552d92cb0870c1cbd1c175691c6b8de29fcb8046bfa79b100cb9' ;; \
		'prometheus-2.53.0.linux-ppc64.tar.gz') sha256='964c232c836bfdb7e69f660dde1b5d3c3d5615674d2018567c7d1b4c3cc0d58f' ;; \
		'prometheus-2.53.0.linux-ppc64le.tar.gz') sha256='962b28660641e26a087e6e8698501b96907d35e9c5c16ab949885000212d603a' ;; \
		'prometheus-2.53.0.linux-riscv64.tar.gz') sha256='1e190d090051cfdc6bb99e681f472ad60ff5c5a387718474da074ac1f0ae1d69' ;; \
		'prometheus-2.53.0.linux-s390x.tar.gz') sha256='b19230f3b36187c9496f49fde0a3f3828d535c58cffc545d80cc91492b845b77' ;; \
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
