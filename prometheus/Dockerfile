#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 3.13.1

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
		'prometheus-3.13.1.linux-386.tar.gz') sha256='52d8ecc8501b343e12ded3be12b0e5eb9d9f3924cef927bc5322827879f36fa0' ;; \
		'prometheus-3.13.1.linux-amd64.tar.gz') sha256='962b812371aff838d152b6ff2d56fdb7a6396f5542f48ebf73421b9721f0d103' ;; \
		'prometheus-3.13.1.linux-arm64.tar.gz') sha256='fbd8e5e0f6ad2e7d053e717739186caee4fd0cab2cf9335bfc86c292fe2a2bfe' ;; \
		'prometheus-3.13.1.linux-armv5.tar.gz') sha256='2ceae55b296e7d92265192042559def6f6c33300e31b9a0133fd4967b3fbeab9' ;; \
		'prometheus-3.13.1.linux-armv6.tar.gz') sha256='017e8dec65481cbc128deffdeaa1bb8419e01a16771ed7e1f3d75d9aa0d244df' ;; \
		'prometheus-3.13.1.linux-armv7.tar.gz') sha256='ba094da83a544a625b8af61ae3becd20fa15ebee4983eff04dc55bbdad81c091' ;; \
		'prometheus-3.13.1.linux-mips.tar.gz') sha256='3c1e2f847dc936bf381a54a24956f35b7e3af5059d050624b48cf4acd37330a3' ;; \
		'prometheus-3.13.1.linux-mips64.tar.gz') sha256='da14f101e6c985cf747ffe6d2bc6b912234e5c30102b3afeb2a538450bbf52a8' ;; \
		'prometheus-3.13.1.linux-mips64le.tar.gz') sha256='b36468e6d6a1491d63606d3e701327bc642df457f7b3bd0379bb70b148da9b8a' ;; \
		'prometheus-3.13.1.linux-mipsle.tar.gz') sha256='4a7e22b637a245638ffeffa8ccab946932a13444f68ed84c4f642a198f90fa4d' ;; \
		'prometheus-3.13.1.linux-ppc64.tar.gz') sha256='f91bfbacfae4453a2282bbb6362bb0fd725f77d48dc91ace6aa463ef83cc8509' ;; \
		'prometheus-3.13.1.linux-ppc64le.tar.gz') sha256='a882a4f441b120619b08ead9064e6e99893f9a101d7c704c09f9b863ef05bdb8' ;; \
		'prometheus-3.13.1.linux-riscv64.tar.gz') sha256='68c248e264542ae1712c86ef6d495247fda9333bac80c1b46757f9ae72de8836' ;; \
		'prometheus-3.13.1.linux-s390x.tar.gz') sha256='5b473bf575736ae0714d34c42b40294b1569dfd25be46bd943d4b236e31426f8' ;; \
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
