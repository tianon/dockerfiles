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
ENV PROMETHEUS_VERSION 2.51.0

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
		'prometheus-2.51.0.linux-386.tar.gz') sha256='8c27e608b9fa628d35389926b57f2a15c3fd1a66f1346ebb4adbf7d7a6e5bbd5' ;; \
		'prometheus-2.51.0.linux-amd64.tar.gz') sha256='ce8b57b5ab3ae5831af3fe9d22d76f91924a0d152f24ecc7cd0b5c02a3c4e3cf' ;; \
		'prometheus-2.51.0.linux-arm64.tar.gz') sha256='25d3e07e64789b2883fd32c312140ad1362199a63db646b4923fffa537cd9702' ;; \
		'prometheus-2.51.0.linux-armv5.tar.gz') sha256='6eaa9b67122977316c8fb88625af3e3998e8c1687eb791a14caa6f9d4493a5d1' ;; \
		'prometheus-2.51.0.linux-armv6.tar.gz') sha256='c0758fbb03678054beb810a5567fda276a983eb137f16a4b4c66cf96ce61a585' ;; \
		'prometheus-2.51.0.linux-armv7.tar.gz') sha256='3bd478a0281dbb411d5f35c6bd1c76532d4e80493d9cc8e7a859d6500a01ec5f' ;; \
		'prometheus-2.51.0.linux-mips.tar.gz') sha256='9c5a08c6aae0ebcbaebf2b54ac223b80a37f4e3f94d2ea05c204bbc65a4d33f2' ;; \
		'prometheus-2.51.0.linux-mips64.tar.gz') sha256='9c8dfb0755628b05d898d38a1133b8651c8dadca4aa801626f2d78e6ebdac78e' ;; \
		'prometheus-2.51.0.linux-mips64le.tar.gz') sha256='66018161e0123ac57f2609c05a41fa916a69159738de77fed8c78cff5c5b5a59' ;; \
		'prometheus-2.51.0.linux-mipsle.tar.gz') sha256='f0e1af5c81e689c0e84963d550b182fa68a3756ed3349469f39955910a61e994' ;; \
		'prometheus-2.51.0.linux-ppc64.tar.gz') sha256='3296753c6ad53df5ed96b7077113f22e7e776575e2dd23ca2f17b137e8680719' ;; \
		'prometheus-2.51.0.linux-ppc64le.tar.gz') sha256='c08af0657d14daf0b45ceb15e2def2ffb9c06ef38348efc9009c60e09c41e832' ;; \
		'prometheus-2.51.0.linux-riscv64.tar.gz') sha256='c165b1c831a5c9d79531c3af4d9d4dc9830cdd74f3bdf0672690850eb6e8e72e' ;; \
		'prometheus-2.51.0.linux-s390x.tar.gz') sha256='859f09264996e96a6f7c9d18d6228d6745b1fc7487074ac94437dca175dc09df' ;; \
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
