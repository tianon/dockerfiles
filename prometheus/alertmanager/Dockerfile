#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.18

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/alertmanager
ENV PATH /opt/alertmanager:$PATH

# https://github.com/prometheus/alertmanager/releases
ENV ALERTMANAGER_VERSION 0.25.0

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
		'alertmanager-0.25.0.linux-386.tar.gz') sha256='daa82af3cb4d3c241f93faa011b0805ee5d357c523ac706ef83b6addd5a7e4da' ;; \
		'alertmanager-0.25.0.linux-amd64.tar.gz') sha256='206cf787c01921574ca171220bb9b48b043c3ad6e744017030fed586eb48e04b' ;; \
		'alertmanager-0.25.0.linux-arm64.tar.gz') sha256='20db5e4e12bcce8e2e419cc4c2bc35062ddbc14d2aacb77e4d5684c0eab7f0fe' ;; \
		'alertmanager-0.25.0.linux-armv5.tar.gz') sha256='1a3dac97b88a2d2ef6c950965c1f84a2fb5eaaa41d5cbaa6d94b7acea522b93f' ;; \
		'alertmanager-0.25.0.linux-armv6.tar.gz') sha256='9539413ef182e55db82e17a01cd4efdd233c78cadf9da28f8e00dcfb8b571af0' ;; \
		'alertmanager-0.25.0.linux-armv7.tar.gz') sha256='3cfd839d4463a7679d32800258b11471498ebc49483273d588818c0432a80af1' ;; \
		'alertmanager-0.25.0.linux-mips.tar.gz') sha256='94219bd0d8500fe4e09ce4d1c1a6b496bc2744add7d741cb988263c8cadee726' ;; \
		'alertmanager-0.25.0.linux-mips64.tar.gz') sha256='5b288c4114bfed9e47ff809ca6350f174d74a41f2689b4da656eead719a0031e' ;; \
		'alertmanager-0.25.0.linux-mips64le.tar.gz') sha256='985ba2d5c5d59ee542656900182d862cb5a9efdf700cee6b91aded57dad12fe4' ;; \
		'alertmanager-0.25.0.linux-mipsle.tar.gz') sha256='f14365d9edaec4708ba58002fd7a103df7def4e61bf5c851f640dc587eb2e8b1' ;; \
		'alertmanager-0.25.0.linux-ppc64.tar.gz') sha256='e6f90ef137a1bd48c6f85cfe19ea8576c0a159a15b0638f5fa3e5ef8733cc3c0' ;; \
		'alertmanager-0.25.0.linux-ppc64le.tar.gz') sha256='60a64b81da8472fca3e3b413f3f812d417f78ff974180a8ecb038e5c7970934c' ;; \
		'alertmanager-0.25.0.linux-s390x.tar.gz') sha256='26e91d3b08e82adb906f93525471c809b2c27a9f62d7482788969859e4a5d516' ;; \
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
