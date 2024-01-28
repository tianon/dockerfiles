#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/alertmanager
ENV PATH /opt/alertmanager:$PATH

# https://github.com/prometheus/alertmanager/releases
ENV ALERTMANAGER_VERSION 0.26.0

RUN set -eux; \
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
	filename="alertmanager-${ALERTMANAGER_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'alertmanager-0.26.0.linux-386.tar.gz') sha256='bd002d98e0b2b84aa5db335711f44bcf9df8072bb97cd7ec7cc6e1a3231f6111' ;; \
		'alertmanager-0.26.0.linux-amd64.tar.gz') sha256='abd73e2ee6bf67d3888699660abbecba7b076bf1f9459a3a8999d493b149ffa6' ;; \
		'alertmanager-0.26.0.linux-arm64.tar.gz') sha256='f65969661821570929ad34cf64e034fe72c8e014855d244321c67a0c3ce3fc08' ;; \
		'alertmanager-0.26.0.linux-armv5.tar.gz') sha256='f7f5dc4b2c5edbb5d12c16076dcba3c1d60395ef061a0a229e08661a39784abf' ;; \
		'alertmanager-0.26.0.linux-armv6.tar.gz') sha256='dedb691e494d7670b78728d70ded8e78d4f1fea1c00d384a793ad6040c6af853' ;; \
		'alertmanager-0.26.0.linux-armv7.tar.gz') sha256='1a88a94c1f6cce900f49daba6142a5900afc92619ce98864663338d74bcf1685' ;; \
		'alertmanager-0.26.0.linux-mips.tar.gz') sha256='716256ea7fc831fc68cb6beff6d90e59c3dd759cdbca8e2f5886cbee10794b31' ;; \
		'alertmanager-0.26.0.linux-mips64.tar.gz') sha256='9ed49f4959609d41fc6b2739b6ef68bf1e717fcf39c439241fda31d63752606b' ;; \
		'alertmanager-0.26.0.linux-mips64le.tar.gz') sha256='354d9dcaaf528ef8bfec86ad66a7514b4198610dc622faa6cbb5dd19afab6e65' ;; \
		'alertmanager-0.26.0.linux-mipsle.tar.gz') sha256='78510fcf2dc3b84b8bd28703a830e9be656b8b211b1f0a1b8ce05e272a2d3f85' ;; \
		'alertmanager-0.26.0.linux-ppc64.tar.gz') sha256='40d46168465ed1a9275d6684486a01bff8b663c6e974f4f85042e01d9ef62015' ;; \
		'alertmanager-0.26.0.linux-ppc64le.tar.gz') sha256='5ccbb4d864fa3785f75667ce59ef2b6ca5794d8c954f56a58551a3175b701928' ;; \
		'alertmanager-0.26.0.linux-s390x.tar.gz') sha256='2e8f10be68680045308f77f344f19a08d939941a9286f2f4952ef9a21af9e593' ;; \
		*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
	esac; \
	wget -O /tmp/alertmanager.tar.gz "https://github.com/prometheus/alertmanager/releases/download/v${ALERTMANAGER_VERSION}/$filename"; \
	echo "$sha256 */tmp/alertmanager.tar.gz" | sha256sum -c -; \
	\
	tar \
		--extract \
		--file /tmp/alertmanager.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/alertmanager.tar.gz; \
	\
	mkdir data; \
	\
	alertmanager --version

VOLUME /opt/alertmanager/data
EXPOSE 9093 9094

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
