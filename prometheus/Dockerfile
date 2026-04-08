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
ENV PROMETHEUS_VERSION 3.11.1

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
		'prometheus-3.11.1.linux-386.tar.gz') sha256='bb10727402b7bb76003a823cc0a2e2218fd7c52616fe52a8927ea1989f4ac742' ;; \
		'prometheus-3.11.1.linux-amd64.tar.gz') sha256='85ee3dd6e3674c7fdad5cffa69a8d7b5ccc93a595227204a0153796a98ee46a4' ;; \
		'prometheus-3.11.1.linux-arm64.tar.gz') sha256='760eaaac0a0666b1f5e56e53f17d9c1fccee1680b91885ae4420150ff2bd6c2e' ;; \
		'prometheus-3.11.1.linux-armv5.tar.gz') sha256='b0e83a0e212dfc4b63e7844b30514f39c1590bb49bf1f388945e417867c8281f' ;; \
		'prometheus-3.11.1.linux-armv6.tar.gz') sha256='a37967e9dd56350c113bf952956c5ca572ba310b880148de9006b956ded9f2e2' ;; \
		'prometheus-3.11.1.linux-armv7.tar.gz') sha256='be20933b8d4575e9638d27cadc04799b82a4a707c21fc03b64df2b1aee073daa' ;; \
		'prometheus-3.11.1.linux-mips.tar.gz') sha256='9c32b6ef74bba369704b9288c90f7e234c6a3ea69d8d452a212f5369f03b60f0' ;; \
		'prometheus-3.11.1.linux-mips64.tar.gz') sha256='d632d075d71b8c3bc65aad3968f2fea4b1a58f8b7855bbeb5e2d4cf13642275d' ;; \
		'prometheus-3.11.1.linux-mips64le.tar.gz') sha256='40d48905e0f55373b0594a12fe562480181201b0c05cec5ca6740e1c185b7e67' ;; \
		'prometheus-3.11.1.linux-mipsle.tar.gz') sha256='b8afd5c78e18cabccc805c15b7a133f65de79c2f390930db479fdc01cd51e985' ;; \
		'prometheus-3.11.1.linux-ppc64.tar.gz') sha256='10da3d162747cb6c3f14b5500bcf059b405fffd2c633c59aa56e39d92f959d9a' ;; \
		'prometheus-3.11.1.linux-ppc64le.tar.gz') sha256='37a9199445c8a2f0b592602ea46afa8de5785a5a3ec33cd7d6017b5872bbd177' ;; \
		'prometheus-3.11.1.linux-riscv64.tar.gz') sha256='2954cde18b227b6993204d4ffe1bdf15aa3ab70ee4acc18ba1084f5f5fb33f7a' ;; \
		'prometheus-3.11.1.linux-s390x.tar.gz') sha256='0969118a8a445413ca65aea76b7083eb9f898219be6976a7c5862a531340e472' ;; \
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
