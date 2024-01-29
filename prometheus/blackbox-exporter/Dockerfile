#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

WORKDIR /opt/blackbox-exporter
ENV PATH /opt/blackbox-exporter:$PATH

# https://github.com/prometheus/blackbox_exporter/releases
ENV BLACKBOX_EXPORTER_VERSION 0.24.0

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
	filename="blackbox_exporter-${BLACKBOX_EXPORTER_VERSION}.linux-$promArch.tar.gz"; \
	case "$filename" in \
		'blackbox_exporter-0.24.0.linux-386.tar.gz') sha256='b44f516622355fab96c0a920dfcbfdd35dfc764870fff93a3afcea09d3df65ec' ;; \
		'blackbox_exporter-0.24.0.linux-amd64.tar.gz') sha256='81b36cece040491ac0d9995db2a0964c40e24838a03a151c3333a7dc3eef94ff' ;; \
		'blackbox_exporter-0.24.0.linux-arm64.tar.gz') sha256='acbbedf03de862fa833bc4dd810e63f105cb44e47abf493192fce3451852dc58' ;; \
		'blackbox_exporter-0.24.0.linux-armv5.tar.gz') sha256='ce6d5f7ec7649a3d643473db7bff2c50245eae1501139d613935de07857919db' ;; \
		'blackbox_exporter-0.24.0.linux-armv6.tar.gz') sha256='36a7d435002641fe19a694801fd6acf8b4189b3e56ea33dbbac34160eb073335' ;; \
		'blackbox_exporter-0.24.0.linux-armv7.tar.gz') sha256='13b6652f69b6ab3d0f84440a893446679662c6f8b4cca360363c41baa4028638' ;; \
		'blackbox_exporter-0.24.0.linux-mips.tar.gz') sha256='ed68ba63a90a77fa46a36be273b5ae934b6528e12c0452d43891e2bb12d0ad20' ;; \
		'blackbox_exporter-0.24.0.linux-mips64.tar.gz') sha256='ee350cd4a665d2c21adbb42f26ba032e34f98883c3b379d2610281582fb44070' ;; \
		'blackbox_exporter-0.24.0.linux-mips64le.tar.gz') sha256='5c774320da7c14d977ceb7f476c59de862fc017faada0700fa174ac831035b9f' ;; \
		'blackbox_exporter-0.24.0.linux-mipsle.tar.gz') sha256='47e4b6a5265fc19a96298058fccdc2c95be2e96093d5199ca91f36e7e9d04cb7' ;; \
		'blackbox_exporter-0.24.0.linux-ppc64.tar.gz') sha256='d85b371081fec7e407a13390ce6739f09b4d739ad979117d1dec3de49e8110c2' ;; \
		'blackbox_exporter-0.24.0.linux-ppc64le.tar.gz') sha256='969b13db059a28ef73f337ab55538dcf0de3ed0d1d4c1fa73dd9016995962599' ;; \
		'blackbox_exporter-0.24.0.linux-s390x.tar.gz') sha256='58dcfa4b4abba0a9eb08e07941ffc74943bcf48450106744a2128625cba026e1' ;; \
		*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
	esac; \
	wget -O /tmp/blackbox-exporter.tar.gz "https://github.com/prometheus/blackbox_exporter/releases/download/v${BLACKBOX_EXPORTER_VERSION}/$filename"; \
	echo "$sha256 */tmp/blackbox-exporter.tar.gz" | sha256sum -c -; \
	\
	tar \
		--extract \
		--file /tmp/blackbox-exporter.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/blackbox-exporter.tar.gz; \
	\
	blackbox_exporter --version

VOLUME /opt/blackbox-exporter/data

EXPOSE 9115
CMD ["blackbox_exporter"]
