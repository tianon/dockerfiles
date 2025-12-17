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
ENV PROMETHEUS_VERSION 3.8.1

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
		'prometheus-3.8.1.linux-386.tar.gz') sha256='62cff6e12435c0b114a285a0c242bd799127520f997a8ab78dd4c73b9c597ac5' ;; \
		'prometheus-3.8.1.linux-amd64.tar.gz') sha256='a09972ced892cd298e353eb9559f1a90f499da3fb4ff0845be352fc138780ee7' ;; \
		'prometheus-3.8.1.linux-arm64.tar.gz') sha256='8d95804e692bba65a48d32ecdfb3d4acd8e1560d440c8cc08f48167cb838ec4b' ;; \
		'prometheus-3.8.1.linux-armv5.tar.gz') sha256='a5b890b5fafb8eab3af99fd59731a16eda8bb0cb91f911127ee6e3c63c5ad0f4' ;; \
		'prometheus-3.8.1.linux-armv6.tar.gz') sha256='6591397cf5a43f603776f7a5f8567c247c357c563a421749f37c953dee242cb3' ;; \
		'prometheus-3.8.1.linux-armv7.tar.gz') sha256='70159946928dce8e11a5d38b6f478b5b6b65533e67c7909644cf613eb59cdf5c' ;; \
		'prometheus-3.8.1.linux-mips.tar.gz') sha256='a5e8f42ce666bbce83c8c14883f81394e3c2a34711db77549724966736df0f7b' ;; \
		'prometheus-3.8.1.linux-mips64.tar.gz') sha256='ff07f24dff75045021cb8302c58708a5866b7e54b762027f5cd0e759361f2de5' ;; \
		'prometheus-3.8.1.linux-mips64le.tar.gz') sha256='5799ae5623d825f4a1c098d22b1e15e027d07d2cfd16d8c527273da083643ba1' ;; \
		'prometheus-3.8.1.linux-mipsle.tar.gz') sha256='2c3e439110fe3bcb38c34b93d00c214f0bf725af04e1781fa84a421a2efcd517' ;; \
		'prometheus-3.8.1.linux-ppc64.tar.gz') sha256='48a16b2c372dc2b08ed0b5d768b32c7cb6078b6cb58b29dc156ab9dd8df688db' ;; \
		'prometheus-3.8.1.linux-ppc64le.tar.gz') sha256='a2f1af8cb54bd362047d507a4e45e7493c178f72b2a3fe02bbbfab8826f698e9' ;; \
		'prometheus-3.8.1.linux-riscv64.tar.gz') sha256='501d8833cc1a4b4b525ece1c254a425feb66daf10730b516969c081d6eb2e846' ;; \
		'prometheus-3.8.1.linux-s390x.tar.gz') sha256='8b06df690c8047c591f921bec1163858bf50784e5940849c4361f5bb8fbd09c2' ;; \
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
