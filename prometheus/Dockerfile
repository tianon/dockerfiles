#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.22

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 3.7.0

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
		'prometheus-3.7.0.linux-386.tar.gz') sha256='e1b405d2ca143f1510118fb54775cc7bac7e6daed6dc0f3bc5c5cc73c24c3a07' ;; \
		'prometheus-3.7.0.linux-amd64.tar.gz') sha256='d54370c807d713fa73bc824ab128bde634ac9a80b37ad3d7768a6a9f63b63089' ;; \
		'prometheus-3.7.0.linux-arm64.tar.gz') sha256='ec52d5ff5d2a6ebc53b2237c7bbdd6651bd67cf3dd1fc928d82ff572cfe1a605' ;; \
		'prometheus-3.7.0.linux-armv5.tar.gz') sha256='526bb3e9ccf8b9f1eed8ef4e47839e702f2c07c3d3f39037b79038b007acb52f' ;; \
		'prometheus-3.7.0.linux-armv6.tar.gz') sha256='a5151ce4999d13643b42c0eb33c057e83f511b05ecfdce728d658d232d64ed3c' ;; \
		'prometheus-3.7.0.linux-armv7.tar.gz') sha256='b89b64ed9fe214ef4526d296471c6262ea20fc778c0dfa0e51130b3162d7ef08' ;; \
		'prometheus-3.7.0.linux-mips.tar.gz') sha256='6fb98e3812d38f2d79c6f6f2e67ba036f3d40f8285fe95709782e1187f5c537a' ;; \
		'prometheus-3.7.0.linux-mips64.tar.gz') sha256='8cacd09c210e3791c773ef10c48dc086c498ad9923e727f35ecc546547f4c8b6' ;; \
		'prometheus-3.7.0.linux-mips64le.tar.gz') sha256='ad7248f95b4a003de4270340a65cb5761d8763949e54fa62f9933185f1a56ab7' ;; \
		'prometheus-3.7.0.linux-mipsle.tar.gz') sha256='4d75d67931c868f8b55d103b2f9cc695db86e306a7064d435c02bbf24c8edec2' ;; \
		'prometheus-3.7.0.linux-ppc64.tar.gz') sha256='a5c6de290debe1ec1e9b70bfc433e46d6c8acf97fba0cbeaa25cc05f4da30804' ;; \
		'prometheus-3.7.0.linux-ppc64le.tar.gz') sha256='b9ab82ff0d49eb9fd8423db5fbec8877f02d7e097b48aadc6aeb837c49d6a80c' ;; \
		'prometheus-3.7.0.linux-riscv64.tar.gz') sha256='288a5fa3e0e74a6ea16e18848323be411811e3c1fde06ed4c047a5c9378b4536' ;; \
		'prometheus-3.7.0.linux-s390x.tar.gz') sha256='3cf6abf0b2b79d3ca80db992b1bcde28832e9f3684c1805d3c4d57a6b5c1fc49' ;; \
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
