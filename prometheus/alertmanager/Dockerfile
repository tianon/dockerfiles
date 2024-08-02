#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.20

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/alertmanager
ENV PATH /opt/alertmanager:$PATH

# https://github.com/prometheus/alertmanager/releases
ENV ALERTMANAGER_VERSION 0.27.0

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
		'alertmanager-0.27.0.linux-386.tar.gz') sha256='53ed44ee699df18f41a3fb4461673ad3ed70df808e16d58dd8ed6040815a0313' ;; \
		'alertmanager-0.27.0.linux-amd64.tar.gz') sha256='23c3f5a3c73de91dbaec419f3c492bef636deb02680808e5d842e6553aa16074' ;; \
		'alertmanager-0.27.0.linux-arm64.tar.gz') sha256='a754304b682cec61f4bd5cfc029b451a30134554b3a2f21a9c487e12814ff8f3' ;; \
		'alertmanager-0.27.0.linux-armv5.tar.gz') sha256='4be93d653c6ea20c8a92a4a568aa4044e727c57d1b91ccb6d6842ce01201f0e3' ;; \
		'alertmanager-0.27.0.linux-armv6.tar.gz') sha256='d1ce28268853e2e316645b5610756088485c38ef7accbc2a6959ad337f0169fc' ;; \
		'alertmanager-0.27.0.linux-armv7.tar.gz') sha256='76b1f4ea8ae769604b1c5ba2b5a24d4f3abe19f06837b69886a597c04b56cef9' ;; \
		'alertmanager-0.27.0.linux-mips.tar.gz') sha256='6f5753c2dab88f6238ec4682e66646a3288822dd066d8b2ea24a637763e62b6c' ;; \
		'alertmanager-0.27.0.linux-mips64.tar.gz') sha256='bb83a11b767947ff53fb80ba0949c1276e2da9feadcfda96a4dd833c9c284b09' ;; \
		'alertmanager-0.27.0.linux-mips64le.tar.gz') sha256='ebbf6a689f22203dac5b4653294b7110ee398bf997583dbcdf04e016bce612e2' ;; \
		'alertmanager-0.27.0.linux-mipsle.tar.gz') sha256='b4575bf0cdeaac23f6de87710495059fed4d984ef9e2a541f1fc66cb692fb808' ;; \
		'alertmanager-0.27.0.linux-ppc64.tar.gz') sha256='62bab56ca6d4112bb46636e845cbb7fd32c5c0b34e05cc382db6e462a892e1cf' ;; \
		'alertmanager-0.27.0.linux-ppc64le.tar.gz') sha256='776ebfbcbc3ad75f7bfc0622c4b9b0e2a6a16e1cd5dc8aded4d878fd2637c7a7' ;; \
		'alertmanager-0.27.0.linux-riscv64.tar.gz') sha256='12348dc14eecbbeb9990cf4cc99d81f2afe3e750815ffdb783efea7b217928b5' ;; \
		'alertmanager-0.27.0.linux-s390x.tar.gz') sha256='107f5786e4f976e8c211dbbcf0b2175112159a3f59ef5110e747004c41518267' ;; \
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
