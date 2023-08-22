#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.18

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 2.46.0

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
		'prometheus-2.46.0.linux-386.tar.gz') sha256='837bb7c518bd6a1478a89fe7229aa5ae4d896c2443af0a7eae0c8f1e6bdcde09' ;; \
		'prometheus-2.46.0.linux-amd64.tar.gz') sha256='d2177ea21a6f60046f9510c828d4f8969628cfd35686780b3898917ef9c268b9' ;; \
		'prometheus-2.46.0.linux-arm64.tar.gz') sha256='f42513c9ef63d6bed652dfc2e986b49ebec714ed784ccaac78e20e0a2a5535bc' ;; \
		'prometheus-2.46.0.linux-armv5.tar.gz') sha256='d5f8f19df634ad5012e5ab6720a2ee181647b9212585574d50f1c1494370d3dc' ;; \
		'prometheus-2.46.0.linux-armv6.tar.gz') sha256='e1535c1d57612efacacbb24f2e3ae39e9b99302d756a8866b5407f72c9681280' ;; \
		'prometheus-2.46.0.linux-armv7.tar.gz') sha256='061e02d077b8f6022cf84fa9b358937c6ba6a1ba8e5914cf38c9a72aabbbe5ff' ;; \
		'prometheus-2.46.0.linux-mips.tar.gz') sha256='c41296f69d1b794c80bcfc5162419605bae3fde7ae790510fcb737847cb9a0be' ;; \
		'prometheus-2.46.0.linux-mips64.tar.gz') sha256='529ee6b32f13b7e98684dd1e98abe87425f80915fb3d8213660ccba6f15ed420' ;; \
		'prometheus-2.46.0.linux-mips64le.tar.gz') sha256='8634fe0171c265463851773119c4bcc28a92275cf7450f673411adaeed122188' ;; \
		'prometheus-2.46.0.linux-mipsle.tar.gz') sha256='4a9bba31e4f8f578ff66bd48559a91d35c3f2956c81d3e7876e7096fac9886c0' ;; \
		'prometheus-2.46.0.linux-ppc64.tar.gz') sha256='7e750667cad37044e9d42c7187dba5566d8ac971ce3fbad27b789dca9c684ab8' ;; \
		'prometheus-2.46.0.linux-ppc64le.tar.gz') sha256='96aeb15871ca5fcf9c12941965f047e2e563b7c757560d0c70ca68cf5f07f7dd' ;; \
		'prometheus-2.46.0.linux-riscv64.tar.gz') sha256='3d008c0ef64dcc07fbcae41aec888108944c2aac73b9ac64d9cd1b24e6c73cf4' ;; \
		'prometheus-2.46.0.linux-s390x.tar.gz') sha256='3a725fd91e8eb6742f8a878fa4d7222585741bc0aaedcbaf950f1c489d7793e4' ;; \
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
