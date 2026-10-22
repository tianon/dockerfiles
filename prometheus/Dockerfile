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
ENV PROMETHEUS_VERSION 3.15.1

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
		'prometheus-3.15.1.linux-386.tar.gz') sha256='04e3891bceffa4a35de31a418a8d48cebe633cbed01d26de320fe258134d5032' ;; \
		'prometheus-3.15.1.linux-amd64.tar.gz') sha256='6a726885328ad9efebbf36e876ce2fb6225468a71fd1e7ce3ba666d5f4d97a84' ;; \
		'prometheus-3.15.1.linux-arm64.tar.gz') sha256='ceb6d21493c37ca0b4513b147642797c68cf39a0f50a444d50e1e80c74f21b26' ;; \
		'prometheus-3.15.1.linux-armv5.tar.gz') sha256='9e660ed6ae67ca3ebabc70a840bcf8afaedc08681d5e4c91a6b11098ccd20254' ;; \
		'prometheus-3.15.1.linux-armv6.tar.gz') sha256='278c2c0baa6f47de39654dfcb5235336788e2e12fe1754d0f485d75c48a817af' ;; \
		'prometheus-3.15.1.linux-armv7.tar.gz') sha256='237e87ca03537496675396e702fe2ac304103fc7d671a2c9ead30d1e639f242f' ;; \
		'prometheus-3.15.1.linux-mips.tar.gz') sha256='5b2ef98b32eaf5871e63ffed29793898cc922bcdb5ac7955558de31815706539' ;; \
		'prometheus-3.15.1.linux-mips64.tar.gz') sha256='4540a92232d62a4ce384445ea32d869bdadaf3e9da1f13a686af7bdf80fd6b1b' ;; \
		'prometheus-3.15.1.linux-mips64le.tar.gz') sha256='ca9282a47f0bb0a92eabda2dc8103c02378b9065c275439b9e2e74a96976495b' ;; \
		'prometheus-3.15.1.linux-mipsle.tar.gz') sha256='54b482a51e313a5223acbc37be15743df9883d343d1dedc7e60ebd613ef0f7d9' ;; \
		'prometheus-3.15.1.linux-ppc64.tar.gz') sha256='b8c61b418f1c81dcd7e6aced65a1bd11ded71893ba2302876bc3c49da18945cd' ;; \
		'prometheus-3.15.1.linux-ppc64le.tar.gz') sha256='80c3fa72a748f8b069289b689b6a86f15bee094a8c7cdd4a41c95a40a6ae3258' ;; \
		'prometheus-3.15.1.linux-riscv64.tar.gz') sha256='2b55d54885f3439942494b6e077112a4e750e97217d31694f3d439dc58cfa366' ;; \
		'prometheus-3.15.1.linux-s390x.tar.gz') sha256='d8f74c8b0752759d315458ec47efa4800dbf7eb1e3cbf346a4c3f8639890f804' ;; \
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
