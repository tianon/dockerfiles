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
ENV PROMETHEUS_VERSION 3.8.0

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
		'prometheus-3.8.0.linux-386.tar.gz') sha256='4ba6a23ee2bde4adfc0459b39ee40ebc1f6ef69885788e0c56d163fbfbd2712c' ;; \
		'prometheus-3.8.0.linux-amd64.tar.gz') sha256='6f451d0331ceb4ae16aefbb2b28762142251fddd7caadd414d030ff55130b25b' ;; \
		'prometheus-3.8.0.linux-arm64.tar.gz') sha256='750b1b70d32dd7bfd5d2da9656e7a8e719658c0b6307aa1759aab4b1bd254498' ;; \
		'prometheus-3.8.0.linux-armv5.tar.gz') sha256='5020a4126255caeb69a15d1ba1e3ecbc11a028eebbc48a5085735aa6978f34de' ;; \
		'prometheus-3.8.0.linux-armv6.tar.gz') sha256='16b0596f4dfb0006e42514e1d343ec66af605cf230ce924be1953f43f1a59408' ;; \
		'prometheus-3.8.0.linux-armv7.tar.gz') sha256='deceadc16d16814e5b9d677985d6eae5c4865c9ba01adcb02b4b371d0626d532' ;; \
		'prometheus-3.8.0.linux-mips.tar.gz') sha256='42e6efcf9e34b53ca36aac3c4197d3d35d0cfb156a7bcc5afe1ce297d99f02d2' ;; \
		'prometheus-3.8.0.linux-mips64.tar.gz') sha256='0ab908d5e247a765d01331866df0296dd1489e16726c1b04ad1509b3fef1879a' ;; \
		'prometheus-3.8.0.linux-mips64le.tar.gz') sha256='64165f8f25c96f560f26f53f947ef61d846bf2b95889816c736ce64ea0e5989a' ;; \
		'prometheus-3.8.0.linux-mipsle.tar.gz') sha256='1c056c52e7f01148322a9c2f1b44e7680fbde57fb3d68a07b1da7e9c8e14d068' ;; \
		'prometheus-3.8.0.linux-ppc64.tar.gz') sha256='1a3fa102a2128164eac04fba0e9f1ec69ac5bf760176516ce273276497743818' ;; \
		'prometheus-3.8.0.linux-ppc64le.tar.gz') sha256='efe1bddbd3be7b8ae1f3fc0b21d47121d0b8b23c9d49c57405435f3e442e349d' ;; \
		'prometheus-3.8.0.linux-riscv64.tar.gz') sha256='b7e30ff19c29f00a7809c2dd7270e6fb45d09fb2a42bad71107502e2e7e96992' ;; \
		'prometheus-3.8.0.linux-s390x.tar.gz') sha256='de9ec998ce14c6237b19965113510a0de9794592aa5190738ed8f8cdf4904de5' ;; \
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
