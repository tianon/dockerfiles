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
ENV BLACKBOX_EXPORTER_VERSION 0.27.0

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
		'blackbox_exporter-0.27.0.linux-386.tar.gz') sha256='b389585a3be0b4626194f5199a5642f102b7dc86439d7b7ec0b2596f7634eb66' ;; \
		'blackbox_exporter-0.27.0.linux-amd64.tar.gz') sha256='507a77ff411822fd6b543e8b8d9e00e1cc49408df465588cd746753bf05046e2' ;; \
		'blackbox_exporter-0.27.0.linux-arm64.tar.gz') sha256='618f0ce44ecec617d5aab28f7e4cb930b41b45fcd3d899536d2b9653fc176e5a' ;; \
		'blackbox_exporter-0.27.0.linux-armv5.tar.gz') sha256='23d9a323de691410b7a46a35926c1937583ff2625139722de4f51fa700fc6fba' ;; \
		'blackbox_exporter-0.27.0.linux-armv6.tar.gz') sha256='368db6938f0a45ce44bddb3d50e1735d6bd14e668a36942c455b552e10d4c67e' ;; \
		'blackbox_exporter-0.27.0.linux-armv7.tar.gz') sha256='d595bb19f4700028f8bb35cd08487b28dd4e3dee56d011dd29253f9e08537ba7' ;; \
		'blackbox_exporter-0.27.0.linux-mips.tar.gz') sha256='f3ddd17b2c68cec42e86b73a9ead9e3843ecfacaf58606a922a912a4ef3a1e70' ;; \
		'blackbox_exporter-0.27.0.linux-mips64.tar.gz') sha256='f693c991a61b1b52b5736175d47fbd990633d208ca41d20e041e1f579ffed1f8' ;; \
		'blackbox_exporter-0.27.0.linux-mips64le.tar.gz') sha256='e518c1c6f4667e97ab20ccc02bc263cd190dc70fc7ebd8dba660130f3ddebb94' ;; \
		'blackbox_exporter-0.27.0.linux-mipsle.tar.gz') sha256='da418590ad2a78d9c1757b0dd7ebdf734697635263e5f76f7ec60fba0c98c2bb' ;; \
		'blackbox_exporter-0.27.0.linux-ppc64.tar.gz') sha256='e0c7ee4edd8da696123a7f81eb14d637afc1e44e14e1baf16bfc00ab226da412' ;; \
		'blackbox_exporter-0.27.0.linux-ppc64le.tar.gz') sha256='b307397a73d090debda79397a20c895ecdf3f2635f4b366f226f5e8175530b47' ;; \
		'blackbox_exporter-0.27.0.linux-riscv64.tar.gz') sha256='af2ce01264c33f49e8dcd9ebc53fe50754b392a800dc528c6272c1bb1f4280d4' ;; \
		'blackbox_exporter-0.27.0.linux-s390x.tar.gz') sha256='dcc98c08a8c3aaf3a606b8b71958fada1c322167bac4059230f8a1f4006a57fe' ;; \
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
