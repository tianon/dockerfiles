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
ENV BLACKBOX_EXPORTER_VERSION 0.28.0

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
		'blackbox_exporter-0.28.0.linux-386.tar.gz') sha256='37d805bf6806acdc962495e3068a8832a0e9fecf0c2ba9442783f240d5740142' ;; \
		'blackbox_exporter-0.28.0.linux-amd64.tar.gz') sha256='caf5d242fb1cf6d5cb678f3f799f22703d4fafea26b03dcbbd7e1f1825e06329' ;; \
		'blackbox_exporter-0.28.0.linux-arm64.tar.gz') sha256='63312be0983d85e5109710a7dc93df3051157ae581853fa3655d171cc1b2806e' ;; \
		'blackbox_exporter-0.28.0.linux-armv5.tar.gz') sha256='378d13885f6e082ff6ff75bc5d8bd5615832445420b8db71d1619575f30e9d42' ;; \
		'blackbox_exporter-0.28.0.linux-armv6.tar.gz') sha256='80c35558e85c0a8e82e73f12ffeffbfe21f948778a17fd8dfc0d804efc812616' ;; \
		'blackbox_exporter-0.28.0.linux-armv7.tar.gz') sha256='3fb45ef352e6a9283fbf12073ed647148ff188a97615aa4d88d4a7668407cb47' ;; \
		'blackbox_exporter-0.28.0.linux-mips.tar.gz') sha256='b8759e6cded80bddc36416b1110a6846877ba5298277530f19d5c8695661f95d' ;; \
		'blackbox_exporter-0.28.0.linux-mips64.tar.gz') sha256='3c659f367b1189d698099ec5542c37b3c6ad54809c7dc46048adf16de78cf4b2' ;; \
		'blackbox_exporter-0.28.0.linux-mips64le.tar.gz') sha256='02e78be2aef29fe2b856fa2830deee2f836f73f1d90df6396ba3d58bcb7453d1' ;; \
		'blackbox_exporter-0.28.0.linux-mipsle.tar.gz') sha256='fd5c32fcfe201c91d230935a35e7743b8a9927dae16a27703db6124bbecc2619' ;; \
		'blackbox_exporter-0.28.0.linux-ppc64.tar.gz') sha256='c1840fd1760b466c8e9dd2d7f2902391c9960cd08b9f47b6de2103baaa07ce61' ;; \
		'blackbox_exporter-0.28.0.linux-ppc64le.tar.gz') sha256='8cccdbd853b5e2d0d4926f28e79613cba72a7af732dff912b5a67139bd0bbd56' ;; \
		'blackbox_exporter-0.28.0.linux-riscv64.tar.gz') sha256='7b30e2305a80b06364d9ff3359b4d659c10dff65e9e9ceaf9572ca22c2002295' ;; \
		'blackbox_exporter-0.28.0.linux-s390x.tar.gz') sha256='e0296003779ce35cd457462d72b9ec92f9889547f85be4abbdfc974723977c5e' ;; \
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
