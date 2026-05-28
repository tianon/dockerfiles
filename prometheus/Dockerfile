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
ENV PROMETHEUS_VERSION 3.12.0

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
		'prometheus-3.12.0.linux-386.tar.gz') sha256='c8e0591b1b8ba2783091635aa4d9d86ab7f90dae527451608a6c4a72d20002e7' ;; \
		'prometheus-3.12.0.linux-amd64.tar.gz') sha256='20da47f8e5303f74aecb78edd7f7e39041dac08ac4939dba75efd7a900ae8867' ;; \
		'prometheus-3.12.0.linux-arm64.tar.gz') sha256='281492bf04ed171cb09d24377e9777f56e55ccb6445ef197b66bd1693bd9b7f1' ;; \
		'prometheus-3.12.0.linux-armv5.tar.gz') sha256='eef1f768c88012cdba4ae8be36f0538bf535edc9821310af3da2709013be5415' ;; \
		'prometheus-3.12.0.linux-armv6.tar.gz') sha256='72b6ed84bd9bd708574ea01294f06aab584291c0b774712e7dd92deb12a4dfd9' ;; \
		'prometheus-3.12.0.linux-armv7.tar.gz') sha256='bdf6da71949a0d4a03d25cc1439d7bd6facf7b1eb98d00ee6cf90fd2872a316a' ;; \
		'prometheus-3.12.0.linux-mips.tar.gz') sha256='e2c9d019d5cbbc96ebaaa482152d000653f813ea50f5738e576e845fc1916cd4' ;; \
		'prometheus-3.12.0.linux-mips64.tar.gz') sha256='f8399a90f9179586d4745530afa7ce888d09f012b67ce1a95ea93fb6584f0655' ;; \
		'prometheus-3.12.0.linux-mips64le.tar.gz') sha256='45549948e9d3ab96c9e7a597e74bf694b504395fada07793bce2808ef7b7a56e' ;; \
		'prometheus-3.12.0.linux-mipsle.tar.gz') sha256='19ec93a4176aa8f9080ab372b3bcaf7d0cdde0aefaf525a610d265a52e8596ac' ;; \
		'prometheus-3.12.0.linux-ppc64.tar.gz') sha256='e622caa292827ec6587ba12d66fed6c79dff8f7649577d9bcd902034ccba9415' ;; \
		'prometheus-3.12.0.linux-ppc64le.tar.gz') sha256='2e5d4bf217e973c813922491abe665a7897578e80260fd9393fddbf20e3fa363' ;; \
		'prometheus-3.12.0.linux-riscv64.tar.gz') sha256='8adf5423bdebbcb341766c0d7d56523333e9b9e17e4ec05a981e4e7665bf11a6' ;; \
		'prometheus-3.12.0.linux-s390x.tar.gz') sha256='c5ac831428ed5d655567f06efc519639c21d21fd1eb4cb292d4781354d66c366' ;; \
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
