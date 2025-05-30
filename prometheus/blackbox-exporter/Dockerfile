#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.22

RUN apk add --no-cache ca-certificates

WORKDIR /opt/blackbox-exporter
ENV PATH /opt/blackbox-exporter:$PATH

# https://github.com/prometheus/blackbox_exporter/releases
ENV BLACKBOX_EXPORTER_VERSION 0.26.0

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
		'blackbox_exporter-0.26.0.linux-386.tar.gz') sha256='19f3ba7adbaf518bcd24c920800a49da1e384ea476ecc2608abc6df8cd59b6c1' ;; \
		'blackbox_exporter-0.26.0.linux-amd64.tar.gz') sha256='4b1bb299c685ecff75d41e55e90aae8e02a658395fb14092c7f9c5c9d75016c7' ;; \
		'blackbox_exporter-0.26.0.linux-arm64.tar.gz') sha256='afb5581b1d4ea45078eebc96e4f989f912d1144d2cc131db8a6c0963bcc6a654' ;; \
		'blackbox_exporter-0.26.0.linux-armv5.tar.gz') sha256='79568cb413be5228d183cb5a20aa8f45a6edb89cc1212d1acbccd040d73665ef' ;; \
		'blackbox_exporter-0.26.0.linux-armv6.tar.gz') sha256='4a721ad66b45536f566a48ce58273aaf4700bbb3e7f95a50fb09a760f168b90f' ;; \
		'blackbox_exporter-0.26.0.linux-armv7.tar.gz') sha256='44ae9312c9b466e16ee1a87200e2d188e023de660c8129a974d4ccc0ba72aa6a' ;; \
		'blackbox_exporter-0.26.0.linux-mips.tar.gz') sha256='98fd411c8566a39490213ab9c05c24b1ae93f092cbb48e30d11492beaeaa2399' ;; \
		'blackbox_exporter-0.26.0.linux-mips64.tar.gz') sha256='a5a45fc39804a5f930e584c1f0b24b8e1b5b5a12b5fb4ca2bb45ac5a1ea9860a' ;; \
		'blackbox_exporter-0.26.0.linux-mips64le.tar.gz') sha256='7593148cf230b2b2aa3415c0a6f833bbab2f355f1a9f0c1b5052f668d336cc5b' ;; \
		'blackbox_exporter-0.26.0.linux-mipsle.tar.gz') sha256='71920675defad623d343535f24d7f0bf2a95528489e3ffddf4d16dd039bfbe68' ;; \
		'blackbox_exporter-0.26.0.linux-ppc64.tar.gz') sha256='01609383e780463a673a1e44ab2ba205a08b724e23605e513965449a6c91cbf1' ;; \
		'blackbox_exporter-0.26.0.linux-ppc64le.tar.gz') sha256='c5408bf04dc20a7ed3f127a41f0adfd2cf89dcfa7a96a590dfd50053d2a32138' ;; \
		'blackbox_exporter-0.26.0.linux-riscv64.tar.gz') sha256='698a26b0eb9f4261c7445aa1f05651aecb8d1e962ae8cfcd5cb4beaf2b774b73' ;; \
		'blackbox_exporter-0.26.0.linux-s390x.tar.gz') sha256='36c42733c87ccbbc6c44e47b758a7290b38ea47885936f6a708406e20046657a' ;; \
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
