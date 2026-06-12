#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache bash ca-certificates tzdata

WORKDIR /opt/alertmanager
ENV PATH /opt/alertmanager:$PATH

# https://github.com/prometheus/alertmanager/releases
ENV ALERTMANAGER_VERSION 0.33.0

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
		'alertmanager-0.33.0.linux-386.tar.gz') sha256='d771053a59f70236d5b1b70b30310e0ded0ba864c6df75a43c06f090e97ae153' ;; \
		'alertmanager-0.33.0.linux-amd64.tar.gz') sha256='8ce11c42e8a6dfbbf93a59c0b193cb1329210b36d0c7ef3df7b745608675a1d1' ;; \
		'alertmanager-0.33.0.linux-arm64.tar.gz') sha256='d01853efe9c61a7009e55d8df98f0f4c9e9b9c58130be177c5812203fd7bfa81' ;; \
		'alertmanager-0.33.0.linux-armv5.tar.gz') sha256='76f46122b5a6b5836e110192096122e067674e963056176e7f9f991de3ef19c5' ;; \
		'alertmanager-0.33.0.linux-armv6.tar.gz') sha256='454016c20269b3ab85140b46b31a5bf580a64c20786725104a0c9f3e3fed5f3b' ;; \
		'alertmanager-0.33.0.linux-armv7.tar.gz') sha256='f21c88f986df69ec1a4951acb5759836ead933aa486d3bcb9cf7eb5a480333c8' ;; \
		'alertmanager-0.33.0.linux-mips.tar.gz') sha256='a1637535b400e4da26e1b0cadfd0d0263dcbc3d3e1246e60adb6012c63a43dbe' ;; \
		'alertmanager-0.33.0.linux-mips64.tar.gz') sha256='0d472ffa79643c683da1e80c8acd61dc20645df9d068813ff2f4b8ed49f2945a' ;; \
		'alertmanager-0.33.0.linux-mips64le.tar.gz') sha256='efa0b7e400ab8b1b8892d99265121f21aed6e184b8f7f82dc7b161b47dc70aca' ;; \
		'alertmanager-0.33.0.linux-mipsle.tar.gz') sha256='3ebf536eacfed439a05d90234437f25ad1fc8f931b2f2986e4efb558f2c547d0' ;; \
		'alertmanager-0.33.0.linux-ppc64.tar.gz') sha256='5b1c16519fbd80c0c9f18e5f548bb55b7138abf4f7a2c77890512c056be807aa' ;; \
		'alertmanager-0.33.0.linux-ppc64le.tar.gz') sha256='a9accaf36e8b22b226c4edf68de8a1a794b22efd029b63b527abb4c4f517ef97' ;; \
		'alertmanager-0.33.0.linux-riscv64.tar.gz') sha256='29bee17f52999e3b62d7659b74a4e23b341cfa547a12a8ca75d14b6d5a01bf85' ;; \
		'alertmanager-0.33.0.linux-s390x.tar.gz') sha256='1628a61a5b01556bcefa1cbab3b24962db8d09ed964dec8c11ec06001b35e088' ;; \
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
