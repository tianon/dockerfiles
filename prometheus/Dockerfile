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
ENV PROMETHEUS_VERSION 2.55.0

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
		'prometheus-2.55.0.linux-386.tar.gz') sha256='fb99f1b89cae1471c4beeb893fd496f9cf5d6811b120bb4d3eab98f160d31c70' ;; \
		'prometheus-2.55.0.linux-amd64.tar.gz') sha256='7a6b6d5ea003e8d59def294392c64e28338da627bf760cf268e788d6a8832a23' ;; \
		'prometheus-2.55.0.linux-arm64.tar.gz') sha256='29965342c79cccba08d28ea530baa38d21d9e6a02e78a565cd59656df6f406c7' ;; \
		'prometheus-2.55.0.linux-armv5.tar.gz') sha256='44116dff852841f397a3d626430e2a2b8046df8fdaf16802c7465047d44d6af0' ;; \
		'prometheus-2.55.0.linux-armv6.tar.gz') sha256='2273d11c08ad86c5335c38bf51b806f1a4f73958f42de97a647d23eb55d40a92' ;; \
		'prometheus-2.55.0.linux-armv7.tar.gz') sha256='ad515a770e39f5786c2a04a94f3291a5f3a5fd366b30919032430abad2c2a32e' ;; \
		'prometheus-2.55.0.linux-mips.tar.gz') sha256='2bf5f5fe3d66238f4d8b171d52c3b8f2fb728ad058178c41aee252d96a2af357' ;; \
		'prometheus-2.55.0.linux-mips64.tar.gz') sha256='bacf501225790f4ba6d332337d6ee0727171e37a65b736f1a5897b8775a0fbf1' ;; \
		'prometheus-2.55.0.linux-mips64le.tar.gz') sha256='03119fab8fc2bb255ab2f2d3241177660a445bdfe604d003495c554ae069581b' ;; \
		'prometheus-2.55.0.linux-mipsle.tar.gz') sha256='416c81d38922997c194759b4804b0c8a9bcaf8d1a636d960997f4b706d14913f' ;; \
		'prometheus-2.55.0.linux-ppc64.tar.gz') sha256='21ef6935115105a16c6c05cd8bf7cc94cde2d3dfadc52d41fdecd1a4bea7ce2b' ;; \
		'prometheus-2.55.0.linux-ppc64le.tar.gz') sha256='34a8f59e3d982b33891fdd9e134ca34d51705bd2367a836cef01480d51de96ab' ;; \
		'prometheus-2.55.0.linux-riscv64.tar.gz') sha256='0517707e5f10dbb8dea3ebd59e8a5833fc413656e1037db3d90f4deb0add87c8' ;; \
		'prometheus-2.55.0.linux-s390x.tar.gz') sha256='bc0afb1fb9d8f4ebf655a5907cb417796ecbe6efc155622823d5633f15a30dcb' ;; \
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
