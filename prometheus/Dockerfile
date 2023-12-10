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
ENV PROMETHEUS_VERSION 2.48.1

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
		'prometheus-2.48.1.linux-386.tar.gz') sha256='9282a228e4fa72669f74bb220bb45ddba5fabcef5c0cf383f5e1ef911302cca9' ;; \
		'prometheus-2.48.1.linux-amd64.tar.gz') sha256='5d58b52ccfeff25700bc8d14ecc1235cbf112a05041e3b2f6900d16b44856f6f' ;; \
		'prometheus-2.48.1.linux-arm64.tar.gz') sha256='2348d1e5a5bb94868eb3293ad4be5967619acc111edb3896272ccdf5853cd20b' ;; \
		'prometheus-2.48.1.linux-armv5.tar.gz') sha256='70e00abf2533e467579bedc1d3022eea6d3f44a802d3d293ceaf2cc5df79c0e1' ;; \
		'prometheus-2.48.1.linux-armv6.tar.gz') sha256='9f73b0c59e6b077981dbfbbe94d718ec52da0c22ce3a21fe03846f9335ff4a57' ;; \
		'prometheus-2.48.1.linux-armv7.tar.gz') sha256='edbe3cb1fc27b048fad28d53d59ca7505f3ea957a4d11b2365e5748d3671b55f' ;; \
		'prometheus-2.48.1.linux-mips.tar.gz') sha256='4328740447c244079a1d287e86f2d0a84818cdb32c89e81075bd65fce8daa264' ;; \
		'prometheus-2.48.1.linux-mips64.tar.gz') sha256='7ff8758461fd6cb4cf8a556959f0509c20036b63d3f472d702fb1c8e7442d8f4' ;; \
		'prometheus-2.48.1.linux-mips64le.tar.gz') sha256='2c5d9cdb01df00d71cd1bd1efb4d8b0a7ae53536f22fe2789de78f720ab6e5c5' ;; \
		'prometheus-2.48.1.linux-mipsle.tar.gz') sha256='54ddc5ef6f5bd58b8a4868adc1fe1b5a3fd5df54e23f9102fbf31833e2677704' ;; \
		'prometheus-2.48.1.linux-ppc64.tar.gz') sha256='ce6ad2f32119925b3655976dc3552afa30b3049a4bf078d78d1f7987d9cd1557' ;; \
		'prometheus-2.48.1.linux-ppc64le.tar.gz') sha256='9f5dc6c0fc7c2535e962fcb4080b6192ef23f9ea25d93178fe7dce133a2dc90c' ;; \
		'prometheus-2.48.1.linux-riscv64.tar.gz') sha256='4d5a00a8df5cd1f3d0d010509517331b2afe7c27b643a5002d6706d34df618ad' ;; \
		'prometheus-2.48.1.linux-s390x.tar.gz') sha256='14e34483b1a83d12d8c0403e5801fc94a794070850392ca041e3b88d88824fd6' ;; \
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
