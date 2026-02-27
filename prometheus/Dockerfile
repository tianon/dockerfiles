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
ENV PROMETHEUS_VERSION 3.10.0

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
		'prometheus-3.10.0.linux-386.tar.gz') sha256='bb6713329bce2658798ce7f358c709978c01063c48ec09603291be7065ce6b22' ;; \
		'prometheus-3.10.0.linux-amd64.tar.gz') sha256='41c50d97bb6a181623fc89d3fe61d0cc68ee69cc93da9091b8bba005f9690122' ;; \
		'prometheus-3.10.0.linux-arm64.tar.gz') sha256='f6fc81c7955b6e1ddd532c62b55896f7e7a61d997a3817ac3534114f2dd33ab1' ;; \
		'prometheus-3.10.0.linux-armv5.tar.gz') sha256='bdd70152a1ef5ba321fb730a07d2ee8423b7700e68fcb884019528c839e40f21' ;; \
		'prometheus-3.10.0.linux-armv6.tar.gz') sha256='3fb2095f89b98d8a936dffac15a160d9973725c372b779b58d655a41e30b3a29' ;; \
		'prometheus-3.10.0.linux-armv7.tar.gz') sha256='e5c60ca4d1f0f329820e10c87b94a8587bab35072020ffb98faaf4dba0097e73' ;; \
		'prometheus-3.10.0.linux-mips.tar.gz') sha256='dcbc81a38a0f15966ec609c4f12f4fc2fcb31e2acf42325470bb49b9840534e2' ;; \
		'prometheus-3.10.0.linux-mips64.tar.gz') sha256='9303b36c7f567fe899f55ef32277e2b3f9c7565e2573810ed27ff552065c9bb3' ;; \
		'prometheus-3.10.0.linux-mips64le.tar.gz') sha256='40b5ef8575cddb349372267274a895b7e6beb31281292bcf907b899881e47a73' ;; \
		'prometheus-3.10.0.linux-mipsle.tar.gz') sha256='1e453c512b6b559e13a8db97d29364458ebbe3f6d846090ce696271ec8df5149' ;; \
		'prometheus-3.10.0.linux-ppc64.tar.gz') sha256='4e8eb80775aa5bc900b444945836cd7fbcd55fafc7af260ac2d72d2d6851f362' ;; \
		'prometheus-3.10.0.linux-ppc64le.tar.gz') sha256='4c579d83032e0095cff0a16ef126773431cf90bb60497a8264635ca4098f11cd' ;; \
		'prometheus-3.10.0.linux-riscv64.tar.gz') sha256='0262429fe2a200578fd79bad20a5d44a98f8c3bb75fc7451d4711783fcb5152e' ;; \
		'prometheus-3.10.0.linux-s390x.tar.gz') sha256='20b400664619ea5b0576cb6ffc167cf284871dbb88f48c2bdacdda24cdbd8be0' ;; \
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
