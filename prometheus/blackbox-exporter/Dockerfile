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
ENV BLACKBOX_EXPORTER_VERSION 0.29.1

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
		'blackbox_exporter-0.29.1.linux-386.tar.gz') sha256='7858d88d41a6679e2bf3bfb711d59d91f717bab3532ded5b10a215848621a95e' ;; \
		'blackbox_exporter-0.29.1.linux-amd64.tar.gz') sha256='b82b81839e6317e84fdd367f46d7ddd3b773fa09cbe2e3d5633a59171d741e76' ;; \
		'blackbox_exporter-0.29.1.linux-arm64.tar.gz') sha256='c597b0d442c02c0f2c8f691cbc7784216c786fada28f300c7b914e1f94523834' ;; \
		'blackbox_exporter-0.29.1.linux-armv5.tar.gz') sha256='d542dbb0af24f776d055e13c8d55b08d95ace45cf2068dfa54ccbd6905296411' ;; \
		'blackbox_exporter-0.29.1.linux-armv6.tar.gz') sha256='e30d79f288f187880a3708382de49eb7f77070b063bbe35e5ada0553f08b0ff3' ;; \
		'blackbox_exporter-0.29.1.linux-armv7.tar.gz') sha256='a19d2fc14f49a480dd2f083ac6a5f81da1ae23473db41e5e7c8773b786e22930' ;; \
		'blackbox_exporter-0.29.1.linux-mips.tar.gz') sha256='662c4c3d0b981b86bcd80c632e30105639173974091d146c8b2afef5968b8fe9' ;; \
		'blackbox_exporter-0.29.1.linux-mips64.tar.gz') sha256='4a1c1e45f4ebf628890fbc660f0675f40b1ddb122648a1df6c95aab8504c0d3e' ;; \
		'blackbox_exporter-0.29.1.linux-mips64le.tar.gz') sha256='8d17ef807f13a1224e1a10c0e95098ef74c795990b2c9d9fc096e3cc7892a1be' ;; \
		'blackbox_exporter-0.29.1.linux-mipsle.tar.gz') sha256='75ecb91f8a97bd3d85e56ce157f945e3299c8ddc48f0d45541289824093d80b8' ;; \
		'blackbox_exporter-0.29.1.linux-ppc64.tar.gz') sha256='08e44283d9c5e04a3154c52616b22ee950c8a5972c898d5f872de186fb7bd755' ;; \
		'blackbox_exporter-0.29.1.linux-ppc64le.tar.gz') sha256='2feeab191ce4af282a0e4d17bd648f58ac5cbd82f6e8c0d79f883116501b5246' ;; \
		'blackbox_exporter-0.29.1.linux-riscv64.tar.gz') sha256='f05f4882e1eab07406132d17b7baa16ab52ab20c156b338e6bd2d2ea8f09c796' ;; \
		'blackbox_exporter-0.29.1.linux-s390x.tar.gz') sha256='8e5ab6e580b2439d237a3e17b5e60be6c126cb1a478670731122f7325452efe0' ;; \
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
