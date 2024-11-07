#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.20

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 2.55.1

RUN set -ex; \
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
	filename="prometheus-${PROMETHEUS_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'prometheus-2.55.1.linux-386.tar.gz') sha256='af17767356b11f70c1b7649f16e5f4b1b0cc549d03b5bc530286a099652dcda6' ;; \
		'prometheus-2.55.1.linux-amd64.tar.gz') sha256='19700bdd42ec31ee162e4079ebda4cd0a44432df4daa637141bdbea4b1cd8927' ;; \
		'prometheus-2.55.1.linux-arm64.tar.gz') sha256='af43368bc6379c3c8bd5ac0b82208060bba22267bf01ad3ab5df56ad5725bf88' ;; \
		'prometheus-2.55.1.linux-armv5.tar.gz') sha256='75708ef0aab1db67ef593ae83de5302cbec9ee595a6a0ff2bc7a53ab3d9eef96' ;; \
		'prometheus-2.55.1.linux-armv6.tar.gz') sha256='65bc2d81f10dbed571031c685a1a4199fa54023bb38c167fb6288b1a3e646d23' ;; \
		'prometheus-2.55.1.linux-armv7.tar.gz') sha256='243f179a86c182a2fc1ba43a9df01620a25f6d256fd5b2f84e2803ce6da971a8' ;; \
		'prometheus-2.55.1.linux-mips.tar.gz') sha256='35620431661867cfb8f499c0f83b9a6d1c36816aa86afd8d5d4c78b097839798' ;; \
		'prometheus-2.55.1.linux-mips64.tar.gz') sha256='168c932983c3e500de67a595db9cc41668600c237d641e707671f880a5bb173e' ;; \
		'prometheus-2.55.1.linux-mips64le.tar.gz') sha256='d285eda64f86710ec049371cbe383c44a2bcf4c087eeb40d9959f2606a147f84' ;; \
		'prometheus-2.55.1.linux-mipsle.tar.gz') sha256='e0a796f2d3ddaa422021e61394f31b4063036318a5f515a2b18998fac05c6c9a' ;; \
		'prometheus-2.55.1.linux-ppc64.tar.gz') sha256='19858c169b8ebd9765da073febb65944c09b64b8330a635102412324f4c62dff' ;; \
		'prometheus-2.55.1.linux-ppc64le.tar.gz') sha256='5ecab97acae173490fef8ab7dbebab9d7ba2d66f89b7059a9625cb31ffb766a3' ;; \
		'prometheus-2.55.1.linux-riscv64.tar.gz') sha256='4527e6b7a4f950d696e22e9546bae608b5316405a4ca2e53c4c46a6e6dc78811' ;; \
		'prometheus-2.55.1.linux-s390x.tar.gz') sha256='62b404b92d5ff7c866d70dad00fbe362ec6ed48371452e079ca1723ea483db1c' ;; \
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
