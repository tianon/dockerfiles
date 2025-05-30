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
ENV PROMETHEUS_VERSION 3.4.0

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
		'prometheus-3.4.0.linux-386.tar.gz') sha256='9b7959c471d3a452795b43ca2e50b602ca7ded1ca89ce9d073473cec20638766' ;; \
		'prometheus-3.4.0.linux-amd64.tar.gz') sha256='e9d80c21f9c4aeefebcc1ab909b1a0cbaaa0950c22ae34cdeda9143ac2392a46' ;; \
		'prometheus-3.4.0.linux-arm64.tar.gz') sha256='88a8c65743ead3952455da041750756405e6517e9007daee34f2afa30a12eef4' ;; \
		'prometheus-3.4.0.linux-armv5.tar.gz') sha256='5f85cf5fe6819d607020857971ee8cb12d7bad9edcc81e0b4862ace6dfe410ac' ;; \
		'prometheus-3.4.0.linux-armv6.tar.gz') sha256='1a44331d576383081d5de7752ca21801784e4c8884fab88d0106a1a222b4af75' ;; \
		'prometheus-3.4.0.linux-armv7.tar.gz') sha256='b11fabc375421c1c4a7670c673d490dfe39e55d6bcc281535124bf42e425bcdd' ;; \
		'prometheus-3.4.0.linux-mips.tar.gz') sha256='cf608b1449308a24e73ab1cca1e6fd7437bc82c8e65b6d4a4cf9a9c0c6f128ad' ;; \
		'prometheus-3.4.0.linux-mips64.tar.gz') sha256='0884dd1b76ca28bb6ae82cdbaad0d6ffbf7dda1fcb95a3a1d6bd2864e970c666' ;; \
		'prometheus-3.4.0.linux-mips64le.tar.gz') sha256='7f5025908a0c2cc2bff978a9f5d681c71f78a12bb2038c130bf81a46d963873a' ;; \
		'prometheus-3.4.0.linux-mipsle.tar.gz') sha256='de5792858a8127ff2d81f05e0160998c6823657b9636c7593dfddf34a5c4a3a1' ;; \
		'prometheus-3.4.0.linux-ppc64.tar.gz') sha256='c0d41ead09053fc19a7a195c7896034d424b72c39ea2de30515b1b4cfdb8bc94' ;; \
		'prometheus-3.4.0.linux-ppc64le.tar.gz') sha256='d1f0214d74104df2712f6ed536b8de54493e5c9a6c455108ade5a4c61e2e8a0c' ;; \
		'prometheus-3.4.0.linux-riscv64.tar.gz') sha256='f5bea844b59d67c166def43fcd74392fa4f6ce4def0281c8c44d012395345277' ;; \
		'prometheus-3.4.0.linux-s390x.tar.gz') sha256='5f94d0f00dde1aa443a18aa5fcc05b942c5c2fe3ac4deb82aba8b4fdd563d2de' ;; \
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
