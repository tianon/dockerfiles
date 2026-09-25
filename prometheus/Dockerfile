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
ENV PROMETHEUS_VERSION 3.15.0

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
		'prometheus-3.15.0.linux-386.tar.gz') sha256='4496ddc48e1b0411a0a3897e223e0b1d61614ba0930997b937ce180c5d97236b' ;; \
		'prometheus-3.15.0.linux-amd64.tar.gz') sha256='2a542df32eac02ee17b9d844fb2aa1de00dafa5476579ba8a3ba862e9d572ea0' ;; \
		'prometheus-3.15.0.linux-arm64.tar.gz') sha256='f1f90ec08e849d494ca66c611470afc50192f0355f1a61c33f2cbde02d067823' ;; \
		'prometheus-3.15.0.linux-armv5.tar.gz') sha256='91f6ca49d91904f1070529634f322f84a7b39b720600f9a791b203bcc05af926' ;; \
		'prometheus-3.15.0.linux-armv6.tar.gz') sha256='281b065d9401a866540fa035ecac379a35614601579e2ef45ad0b1369b8c5248' ;; \
		'prometheus-3.15.0.linux-armv7.tar.gz') sha256='66c26d503b8600fd512f9fddf6937f37597c4d35cc162c329b8a6c3c7d67def0' ;; \
		'prometheus-3.15.0.linux-mips.tar.gz') sha256='24b6d2d3327cff5ed6bf7214c3c5b6a8b111607be647962f2e884eceb140cabd' ;; \
		'prometheus-3.15.0.linux-mips64.tar.gz') sha256='bfd6c4b3578563c0e6f84a9c0b3f60031d0c449cddc3e4d65e7b37b9be4b3322' ;; \
		'prometheus-3.15.0.linux-mips64le.tar.gz') sha256='6613d718c5c4d55aeb6e923377b86f7ca917a98f0809c3fa65bef833ed6a13e3' ;; \
		'prometheus-3.15.0.linux-mipsle.tar.gz') sha256='d79cc0461904ff00322bbd649d475bfb4ff03a8b460671c11a0a70ca89f4acc5' ;; \
		'prometheus-3.15.0.linux-ppc64.tar.gz') sha256='c2f5b6aee96c9a92aaaaadafa7e22005d51c0ac16bc884360cd0d0ab9498a4dc' ;; \
		'prometheus-3.15.0.linux-ppc64le.tar.gz') sha256='f7574993e1192643f37d8791d55ee632a52351e1a619291f66bf57f03731c5ae' ;; \
		'prometheus-3.15.0.linux-riscv64.tar.gz') sha256='cd76ccda504ba1bebc9b727f85def5fb0fc60d1b07e7ff37c96bf8d96a8ff431' ;; \
		'prometheus-3.15.0.linux-s390x.tar.gz') sha256='6f4dd37179046ed0e96f0a3971ce2e221d7884e3ea64f1ee3255856285b6f18d' ;; \
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
