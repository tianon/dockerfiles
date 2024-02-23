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
ENV PROMETHEUS_VERSION 2.50.0

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
		'prometheus-2.50.0.linux-386.tar.gz') sha256='15d226b2ba1f943463920746fd7ce4c4b910698e0f28f71024b867959f7bfee0' ;; \
		'prometheus-2.50.0.linux-amd64.tar.gz') sha256='f3fb61f970d5c606320a3ca819d621f005f5276bdee0138cdc42f7def08cb00e' ;; \
		'prometheus-2.50.0.linux-arm64.tar.gz') sha256='23dce3e41876e959bbf963caaaf73b26f16b0957be75e99c0a1e6923c2ab3c44' ;; \
		'prometheus-2.50.0.linux-armv5.tar.gz') sha256='975e2dd87953a2d3d3151fe496dbd83695943ed76d9ab61c0077d2e20d607c0a' ;; \
		'prometheus-2.50.0.linux-armv6.tar.gz') sha256='feecd06648a1d38d87287949c319ddf2de9f7ed30436954dface2348d32be61e' ;; \
		'prometheus-2.50.0.linux-armv7.tar.gz') sha256='0f7882ca5eb3dc67a53d8f92b54a5081efa74fd18514a900fe7e743f9b5aa850' ;; \
		'prometheus-2.50.0.linux-mips.tar.gz') sha256='5c27111b0e8f98f81150fc81dd2b4998615acddc0962f0cd0eff8aa00ad14409' ;; \
		'prometheus-2.50.0.linux-mips64.tar.gz') sha256='b0f52ab82a67157c91667564f3b650fe0edd53e079367b930fb722964776c187' ;; \
		'prometheus-2.50.0.linux-mips64le.tar.gz') sha256='fd31e520a79df7aafe98d185f58bd72ab48172527418da5a4b756edc3e07fa13' ;; \
		'prometheus-2.50.0.linux-mipsle.tar.gz') sha256='1c99bc26c4087bc45a9f59385c9fca907d7f8b4e77b3ad129d4a6b4d7f136eb9' ;; \
		'prometheus-2.50.0.linux-ppc64.tar.gz') sha256='910dd7d6de94d3732f506945d1386e5b6371333561857a78d67339d599407ff9' ;; \
		'prometheus-2.50.0.linux-ppc64le.tar.gz') sha256='ae7c2e921de18997a0b0fc5fe7c8172a0a9435d22d2d4092d60e09321560027a' ;; \
		'prometheus-2.50.0.linux-riscv64.tar.gz') sha256='f8c34832a20a73ae3af1774628e8c9e92429996a24b8c891ed0adce543786b8a' ;; \
		'prometheus-2.50.0.linux-s390x.tar.gz') sha256='df572eaae306abd3dbc25ed684495ecbb1abde432083b1e3cdafe4cd9d113b28' ;; \
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
