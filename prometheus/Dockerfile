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
ENV PROMETHEUS_VERSION 3.13.0

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
		'prometheus-3.13.0.linux-386.tar.gz') sha256='cdf29047fbb161764d53436e1bb02003e3aee14c0540a9e3d2ff49dadca32fa8' ;; \
		'prometheus-3.13.0.linux-amd64.tar.gz') sha256='744d93324cc024d82089921737bd797474d7f1e5dbbfd1c6b387bad258538cb9' ;; \
		'prometheus-3.13.0.linux-arm64.tar.gz') sha256='c11fbff0fde0e357e4cfcf2ec74b83d5475301da7e6777c6d7b6aa6d06a410f7' ;; \
		'prometheus-3.13.0.linux-armv5.tar.gz') sha256='62029ba4c12391578cdc82e43d0052385ab1a4813a36cbce8942d7ee0bb26cc7' ;; \
		'prometheus-3.13.0.linux-armv6.tar.gz') sha256='945319d6969f38109adf3b7b07d7c3c5c6987ab281747e3e3caebe877484b30e' ;; \
		'prometheus-3.13.0.linux-armv7.tar.gz') sha256='1042005d19ef9bff8016ce62db9b8215698b9d6b58b6d192ae47a0dbfad2e2a5' ;; \
		'prometheus-3.13.0.linux-mips.tar.gz') sha256='3343c9e9ed92f2e24cdda31425af1fb722694ab06a435618f861fd5fb37f4604' ;; \
		'prometheus-3.13.0.linux-mips64.tar.gz') sha256='6aed3880a762e9fdd3f98c0347a3e37ea98c83721b346eac7740b3e3e7a33ef2' ;; \
		'prometheus-3.13.0.linux-mips64le.tar.gz') sha256='80559e0016ea52add6b4699e3c88ce01434825d78343798673c513fdfec65360' ;; \
		'prometheus-3.13.0.linux-mipsle.tar.gz') sha256='bfdd00f98aae84268aefe960de42d1bf9dbb5eda334088bda0037e40f8771280' ;; \
		'prometheus-3.13.0.linux-ppc64.tar.gz') sha256='a3f23768f62801598510950d115dc358cd114a6069e73def6f84c93b898421cb' ;; \
		'prometheus-3.13.0.linux-ppc64le.tar.gz') sha256='e136eee7bd74a5ece680db6bbab9673fa8d83e745a37f26193ec9bab5ffd6d92' ;; \
		'prometheus-3.13.0.linux-riscv64.tar.gz') sha256='4cd676102b033060b2c7763dde9df29c7bee8f241f30c9297ae7d97cd2fbe297' ;; \
		'prometheus-3.13.0.linux-s390x.tar.gz') sha256='54d195b8c97b07d3a9f0c5b3568ebd1bdd8e03a4a204a7a814bcaf22fce76a64' ;; \
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
