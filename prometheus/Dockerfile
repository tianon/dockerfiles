#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.21

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 3.1.0

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
		'prometheus-3.1.0.linux-386.tar.gz') sha256='c29e3b4d73d258538ebc05bb49713501c838545381f65c775d6d3a972a3e42f7' ;; \
		'prometheus-3.1.0.linux-amd64.tar.gz') sha256='9a9d1e115d1745826b13aec3f1409780b9fcf1d4206746cb4faee46ca5add70c' ;; \
		'prometheus-3.1.0.linux-arm64.tar.gz') sha256='c12b9e368006873df0c8865771af0434a3edfc8c8eaeea62b73d3974bff7f2a1' ;; \
		'prometheus-3.1.0.linux-armv5.tar.gz') sha256='dcc4f156729558f2070532be2ecb86de03322bbaa74802e06e98fd0c4494adb5' ;; \
		'prometheus-3.1.0.linux-armv6.tar.gz') sha256='b91978e9689ea61dd52a86dde9980c498e108c7293c89abf7ba197fcbae1a5bb' ;; \
		'prometheus-3.1.0.linux-armv7.tar.gz') sha256='9f4a7998820938ac974ebaa3d703651a6fe5e3dc714f1e2606687c2316f86005' ;; \
		'prometheus-3.1.0.linux-mips.tar.gz') sha256='9599129485f052d9a9e68b2a46a79c995d852fa0bf67d103eb558b875b850972' ;; \
		'prometheus-3.1.0.linux-mips64.tar.gz') sha256='633f3f36a97b51a04d1284577fb63fce39ea5aeba210fa6e61882a00207a7cac' ;; \
		'prometheus-3.1.0.linux-mips64le.tar.gz') sha256='164440214fc74cfb0b4316005d833e3d4d432075f95ca5959055dd31ebcd2965' ;; \
		'prometheus-3.1.0.linux-mipsle.tar.gz') sha256='c2984ead56cd4a984b18bfa6d970d0fb5aa16e79e244a632da3e7d5d988d1a5c' ;; \
		'prometheus-3.1.0.linux-ppc64.tar.gz') sha256='3524b832f25ae0287f232d7bfacf8bac8ac51a4c24664233610e2a9f239d2c1b' ;; \
		'prometheus-3.1.0.linux-ppc64le.tar.gz') sha256='108c8994a5a2ee20ddb5f6f543d0c6bbdc9ddee36b4c01eb870a3369308595e2' ;; \
		'prometheus-3.1.0.linux-riscv64.tar.gz') sha256='4a6bead5f5fe8cbc79df5d19e9060c47223e02da21ccddbebf7d00d06d313293' ;; \
		'prometheus-3.1.0.linux-s390x.tar.gz') sha256='cbdd77975d2f6e7d048a42feffb02bcb93495be86fafa50ebdf96ff1bc723940' ;; \
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
