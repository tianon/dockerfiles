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
ENV PROMETHEUS_VERSION 2.47.2

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
		'prometheus-2.47.2.linux-386.tar.gz') sha256='5032a8aa7c4a5db4b335bf017a39a91cbac610fc9b73dfe5ae8a5cf1ecd5c728' ;; \
		'prometheus-2.47.2.linux-amd64.tar.gz') sha256='6f48cd8d748cbb8e61d0cee825b63e80d8de370dc8ca19ff6eb0326f45f6e525' ;; \
		'prometheus-2.47.2.linux-arm64.tar.gz') sha256='c8d9bac223b630c3e893e0793c99b3e9d35f6d62719193060cce31cab8a30528' ;; \
		'prometheus-2.47.2.linux-armv5.tar.gz') sha256='a9148dba7c16eebd3e9c5e5c9690bbcc57bc73ae13e3aed1d5b48fe145302bda' ;; \
		'prometheus-2.47.2.linux-armv6.tar.gz') sha256='379490927b62eded65882866e2f255af8b1204b32236a42a6ea30754b91d7a10' ;; \
		'prometheus-2.47.2.linux-armv7.tar.gz') sha256='298f783fdc442f86b17857d0a164ad2bd95e30b9e204df20147e544bf987c9d7' ;; \
		'prometheus-2.47.2.linux-mips.tar.gz') sha256='4c829a2640ee42347d1321e6c99a619cf7d2e107b644afecffa7c9c792e536e6' ;; \
		'prometheus-2.47.2.linux-mips64.tar.gz') sha256='4b984b5b33a7985fd84ccd2d028dd95deadb9bb0a8902bf2c8cfb167990ee01a' ;; \
		'prometheus-2.47.2.linux-mips64le.tar.gz') sha256='632efb834db4e332993ff4bab53a9787d4f4692a0a8a8c2a18de78d6f7ea8820' ;; \
		'prometheus-2.47.2.linux-mipsle.tar.gz') sha256='44f315c106c93ba1b67438bc6e674406f8d99224d3e824e734e05870f13060fc' ;; \
		'prometheus-2.47.2.linux-ppc64.tar.gz') sha256='d9a16156e3fdeb844dad5e239e04445a7da87b8702d7c6834dc55819d1b1a665' ;; \
		'prometheus-2.47.2.linux-ppc64le.tar.gz') sha256='bfa6a6a2fc668a3f069053b7da08fb6aa27454f50d7b69bffd7aef878fc117ed' ;; \
		'prometheus-2.47.2.linux-riscv64.tar.gz') sha256='c3f6b389b04587e16f70b93791793df16af89ba7a08ede84c0f5149e3e1b6c03' ;; \
		'prometheus-2.47.2.linux-s390x.tar.gz') sha256='48bb43df5c55081a49a0c2cf0a41556e99a64ce1f96e931dc8f065eba7c05c04' ;; \
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
