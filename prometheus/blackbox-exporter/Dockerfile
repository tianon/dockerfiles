#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache ca-certificates

WORKDIR /opt/blackbox-exporter
ENV PATH /opt/blackbox-exporter:$PATH

# https://github.com/prometheus/blackbox_exporter/releases
ENV BLACKBOX_EXPORTER_VERSION 0.29.0

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
	filename="blackbox_exporter-${BLACKBOX_EXPORTER_VERSION}.linux-$promArch.tar.gz"; \
	case "$filename" in \
		'blackbox_exporter-0.29.0.linux-386.tar.gz') sha256='9be89a12a0925904e329f425ea8b880b200a12e386903c7d6baf2975464e596f' ;; \
		'blackbox_exporter-0.29.0.linux-amd64.tar.gz') sha256='5512929259bb6164f68ebe20ce433ec43b8609e3a79c95324f5020e931488fb4' ;; \
		'blackbox_exporter-0.29.0.linux-arm64.tar.gz') sha256='743c490a2386c5b77ad13e7af30cde48651c03ffe9f61d39b99c578baa7e8e34' ;; \
		'blackbox_exporter-0.29.0.linux-armv5.tar.gz') sha256='f07132551e27e046fce171207edd20cd5bc8ade14f617bdc4202a1cc9c284beb' ;; \
		'blackbox_exporter-0.29.0.linux-armv6.tar.gz') sha256='1e990b53354081e673c9bd7477e33ea90e2156594e19011fe417a385fea93e59' ;; \
		'blackbox_exporter-0.29.0.linux-armv7.tar.gz') sha256='8f8a318cf3be2eed347c52d0e91e3297f8eaedb6d03720cc10868b7c753f38cb' ;; \
		'blackbox_exporter-0.29.0.linux-mips.tar.gz') sha256='4a9748fbe168cc325e5d4610a77bb4f5b2b8050016e91fb24bbc14edc2500441' ;; \
		'blackbox_exporter-0.29.0.linux-mips64.tar.gz') sha256='a0351a0562a8e299d58396eca8e70022d6d19d36b245b9b2d013162c7cbf6650' ;; \
		'blackbox_exporter-0.29.0.linux-mips64le.tar.gz') sha256='d072a21c7d7dba36f7bf6f4e084f6bfc9fb32feadd0e0cb8b282a396d7ad69fa' ;; \
		'blackbox_exporter-0.29.0.linux-mipsle.tar.gz') sha256='18ecd2e014c6b48006e8b1608b54e96e094781f26937e7af4e3c865fee7473f0' ;; \
		'blackbox_exporter-0.29.0.linux-ppc64.tar.gz') sha256='fc3b7034935ff99ea5397544fe0a73ad4159de96f0856bc6cfbb5496474e1bf0' ;; \
		'blackbox_exporter-0.29.0.linux-ppc64le.tar.gz') sha256='05e36bec8556d408d373d0cf8878cc0cd5c8e2b9c81a9fae7ff70413b2f6e84b' ;; \
		'blackbox_exporter-0.29.0.linux-riscv64.tar.gz') sha256='3c3c5f787b36ae4a12c3e40a597bb65f3b243300a1ffa9e1be8b52ccf54c1020' ;; \
		'blackbox_exporter-0.29.0.linux-s390x.tar.gz') sha256='e06969fdc0a225a0ead783f6a3d3ac7b650e8e1aaa4473161bf8f704e0f28419' ;; \
		*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
	esac; \
	wget -O /tmp/blackbox-exporter.tar.gz "https://github.com/prometheus/blackbox_exporter/releases/download/v${BLACKBOX_EXPORTER_VERSION}/$filename"; \
	echo "$sha256 */tmp/blackbox-exporter.tar.gz" | sha256sum -c -; \
	\
	tar \
		--extract \
		--file /tmp/blackbox-exporter.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/blackbox-exporter.tar.gz; \
	\
	blackbox_exporter --version

VOLUME /opt/blackbox-exporter/data

EXPOSE 9115
CMD ["blackbox_exporter"]
