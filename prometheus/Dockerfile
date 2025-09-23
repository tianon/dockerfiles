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
ENV PROMETHEUS_VERSION 3.6.0

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
		'prometheus-3.6.0.linux-386.tar.gz') sha256='9eaba926f3a0d1d03a8616f6664c3d4f0baa06ca10489dce8bffe276c2173170' ;; \
		'prometheus-3.6.0.linux-amd64.tar.gz') sha256='2002ef4a55a64161affccd2786c7081d4e3b3a8d08786a98b3bb110971414916' ;; \
		'prometheus-3.6.0.linux-arm64.tar.gz') sha256='f7e66b9d47e86988fe8e7cb5a5b326cab6c56f5a74ba7133b899ef1daedaf633' ;; \
		'prometheus-3.6.0.linux-armv5.tar.gz') sha256='057e597249f48cf0d683c24d4428d1ec8262e4d1864677c0a972d5a441129adb' ;; \
		'prometheus-3.6.0.linux-armv6.tar.gz') sha256='4f5960d38d6f4871631e3f2a684e14b2b45f4e7e716e087fcecb33ddc64df47a' ;; \
		'prometheus-3.6.0.linux-armv7.tar.gz') sha256='2a97ab4807a322c736ba28e7d862dbf4fbcc4af7cc9f726221a31a56990a6815' ;; \
		'prometheus-3.6.0.linux-mips.tar.gz') sha256='b066462719bb716bd6a9825bedabfbacc054e056c352ce4cb4f77e598fa73dd7' ;; \
		'prometheus-3.6.0.linux-mips64.tar.gz') sha256='a163c8f6c58c82eeb9742059997f4221c2ae6d15bbe10e51daeba45029f7936f' ;; \
		'prometheus-3.6.0.linux-mips64le.tar.gz') sha256='3c577155d3d861f522bd6c30b861aa9c82d9cead8fce4c4a886cac15337ab6a8' ;; \
		'prometheus-3.6.0.linux-mipsle.tar.gz') sha256='425a00a786917c25aa452693617a6751e39fa1db553c2a3926f86d1671097294' ;; \
		'prometheus-3.6.0.linux-ppc64.tar.gz') sha256='779ef55d380351bb433a975ac213e6fdd96cf4665bc151edc389bd2368125907' ;; \
		'prometheus-3.6.0.linux-ppc64le.tar.gz') sha256='3d1ba2b43b31b35c22ba496b0fb98e55c9c9059417494cfc9b88cf4cca9f1cb1' ;; \
		'prometheus-3.6.0.linux-riscv64.tar.gz') sha256='67f9eb8e6bccc161bac5a8b9d9ae23ee525b9672bfe89000c0e80cca8955ceaf' ;; \
		'prometheus-3.6.0.linux-s390x.tar.gz') sha256='349e58b16cf8c0cab68279f746568379a170e0cc21cfcfb16908635c4c356e36' ;; \
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
