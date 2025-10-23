#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.22

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 3.7.2

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
	filename="prometheus-${PROMETHEUS_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'prometheus-3.7.2.linux-386.tar.gz') sha256='d172a89788b840366e6d8184b2c8e2329d2146bba61a62eeb714e68f7bf59844' ;; \
		'prometheus-3.7.2.linux-amd64.tar.gz') sha256='6558bcc43c1d3df5ce24f0fe82e605ce8fd9da0d9e779fdfbaf5e97972215571' ;; \
		'prometheus-3.7.2.linux-arm64.tar.gz') sha256='b8990f02ee65ae820489daa5d7a4be912684e9f75e5b4c89e4001ede335679d1' ;; \
		'prometheus-3.7.2.linux-armv5.tar.gz') sha256='cd8dea681f8b4740c655fcf2cfbca832fb0d6167d9eaee58f2d801a3f475cbc8' ;; \
		'prometheus-3.7.2.linux-armv6.tar.gz') sha256='085ee47e26915413c4676506a1cec1698f2024759886df4c2d1ddb2620c34403' ;; \
		'prometheus-3.7.2.linux-armv7.tar.gz') sha256='932bdaf5b0e8fa1f1a9478768a7f43e832876872d85ca005836c0122c9c872ef' ;; \
		'prometheus-3.7.2.linux-mips.tar.gz') sha256='7bb491ce2108f76f8eda61c2cc02f98b9b5fc7a8a35041a104bc11bdf65642ee' ;; \
		'prometheus-3.7.2.linux-mips64.tar.gz') sha256='378549d6dd19dc70a973d1c8f68560bad1ff7d9b802dff1cfa34cc173b028867' ;; \
		'prometheus-3.7.2.linux-mips64le.tar.gz') sha256='c9b98f7c11527306eb1fa9b92fc27ba269d17c7afcf19cbdcd6b62b9ee737a10' ;; \
		'prometheus-3.7.2.linux-mipsle.tar.gz') sha256='e2f989fa4f03c7a32c622b2067f5012a6a8ed838fd14e4c60945357b33db90d7' ;; \
		'prometheus-3.7.2.linux-ppc64.tar.gz') sha256='fa31273dada27ab4e9a6ac7c84ace028edb929ab3c11e0828f85f4d997541928' ;; \
		'prometheus-3.7.2.linux-ppc64le.tar.gz') sha256='3bd59f359347fb3f1c3e2894c62dfa744f89a7a2f36dfd5cba478665a85f977c' ;; \
		'prometheus-3.7.2.linux-riscv64.tar.gz') sha256='65911119d7a09fba9c1c381a60aa09610fa41504f70f9f3b7f2fbd59c262feaa' ;; \
		'prometheus-3.7.2.linux-s390x.tar.gz') sha256='adf245ebca41356a78a9c17d4979ea42e202a9bbb64d2e3fc93cbf3e951a99c4' ;; \
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
