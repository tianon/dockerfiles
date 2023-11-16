#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.18

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 2.48.0

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
		'prometheus-2.48.0.linux-386.tar.gz') sha256='6b946c62137eefa8a272e0184c2cbe08a54136bebdcaa168e278aaed2c12a8ba' ;; \
		'prometheus-2.48.0.linux-amd64.tar.gz') sha256='5871ca9e01ae35bb7ab7a129a845a7a80f0e1453f00f776ac564dd41ff4d754e' ;; \
		'prometheus-2.48.0.linux-arm64.tar.gz') sha256='c6e85f7b4fd0785df48266c1ee53975f862996a99b7d96520dc730e65da7bcf6' ;; \
		'prometheus-2.48.0.linux-armv5.tar.gz') sha256='8aad7a5143335788bc1a16c198d4d1b4b390a87f9bf9cbec1fbf0c25424dfb6b' ;; \
		'prometheus-2.48.0.linux-armv6.tar.gz') sha256='e1dbe5adfdf033f7f308f15c0b913edba1cd287021c81c01117c331aab4ef1fc' ;; \
		'prometheus-2.48.0.linux-armv7.tar.gz') sha256='b4996550b56048a4b9a3937e0f5ff119c6fa33f937baf44007e5b9b4ce9779b1' ;; \
		'prometheus-2.48.0.linux-mips.tar.gz') sha256='832f42ba3e066f1958ec38a8b1e2d1850988770bcdea01c0056fb881219d0917' ;; \
		'prometheus-2.48.0.linux-mips64.tar.gz') sha256='6bedb8af7eccd703710c4b1aa3342698a708aed7f1bf22a11965bec3eadd7589' ;; \
		'prometheus-2.48.0.linux-mips64le.tar.gz') sha256='a3253c43108dc5db2fd09470e7e0374b2955f17f8af2cec6e91c2954cff9530c' ;; \
		'prometheus-2.48.0.linux-mipsle.tar.gz') sha256='45658f5397e4a276b9e4a61318d3303a5054d344dbf94f39b2ada64f7f02b67c' ;; \
		'prometheus-2.48.0.linux-ppc64.tar.gz') sha256='3224ecb12382e658faf43f9d1ddc55ea48607b7eee983e99cfb998c570a88a35' ;; \
		'prometheus-2.48.0.linux-ppc64le.tar.gz') sha256='5fe713c5ebc709867bf360b097b15996de47dd7f1201b52a9e8675d43334a6b6' ;; \
		'prometheus-2.48.0.linux-riscv64.tar.gz') sha256='83ad2a6ad0b6f42a688dcb6c27f55dd83ed0adfb650f8710cd51ef49e328c57d' ;; \
		'prometheus-2.48.0.linux-s390x.tar.gz') sha256='d6b9d9b143cd47a617a4ce43329f9bc7aaed147c7a7516d53aeee9ae14f9b177' ;; \
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
