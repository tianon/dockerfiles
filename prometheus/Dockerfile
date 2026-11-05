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
ENV PROMETHEUS_VERSION 3.16.0

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
		'prometheus-3.16.0.linux-386.tar.gz') sha256='a29f36b20697ac08916555e995c3fce54bedaa7e6771f88c50bc6a5f148136c6' ;; \
		'prometheus-3.16.0.linux-amd64.tar.gz') sha256='68727009472a2c02e1ff7f062fd5b3e637285bffc8fc2d340c76fb449d6e0f34' ;; \
		'prometheus-3.16.0.linux-arm64.tar.gz') sha256='fd8571b8162f4020232d886f17340bcf92e1722985ae3b4c1d096157826c0fbe' ;; \
		'prometheus-3.16.0.linux-armv5.tar.gz') sha256='4af55e30e0761dfac0eb765ee1cf8ee010f3d502fe457ae99417778c9372119c' ;; \
		'prometheus-3.16.0.linux-armv6.tar.gz') sha256='53611b47d0a21ab16d160245ce339fe34f518926aec190ed2c6e5f89ed16a22f' ;; \
		'prometheus-3.16.0.linux-armv7.tar.gz') sha256='428cc25a679c2ba9d40197d11cfee78a88bfdb0eed71b2cd02307a8518bb4199' ;; \
		'prometheus-3.16.0.linux-mips.tar.gz') sha256='f14c6911ef23b3188b68701e21e375babb5fb6a984b8a9ecef8feec013fddb8f' ;; \
		'prometheus-3.16.0.linux-mips64.tar.gz') sha256='9077913fd8fce6a65d121f3b3fe3aceabfcfbc4460869a533ac9ddcf39f928a3' ;; \
		'prometheus-3.16.0.linux-mips64le.tar.gz') sha256='b48f16310ce1502e3771f4f5de00425f96a47e043b836f820e4f7b7227048884' ;; \
		'prometheus-3.16.0.linux-mipsle.tar.gz') sha256='2409237074ae8fc8c855594f67600a0e357cb0eec6f8c919ca8bb9e6425172c0' ;; \
		'prometheus-3.16.0.linux-ppc64.tar.gz') sha256='1bf0b0066c229a77441d6ff0a5354012d8b4cb888e93a2ae4cd789df6879c72e' ;; \
		'prometheus-3.16.0.linux-ppc64le.tar.gz') sha256='922e25fd73dd533f972d56b6bc32ca8161115afbbfa1a93b6576bfab9812a8cb' ;; \
		'prometheus-3.16.0.linux-riscv64.tar.gz') sha256='b0fd535d2c85ffae27b03f0db39d8d3c17211810fc989f599ccf9bb15fc4d7bd' ;; \
		'prometheus-3.16.0.linux-s390x.tar.gz') sha256='90123b0bf0b7b61e245ad2ac414a1adcac60de5603f09e9c5df6a759b51592d7' ;; \
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
