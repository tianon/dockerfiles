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
ENV PROMETHEUS_VERSION 3.4.2

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
		'prometheus-3.4.2.linux-386.tar.gz') sha256='9d38fef6d2cd0e46e5b7168dac118a77381afba0067081576649d8c9eff0add5' ;; \
		'prometheus-3.4.2.linux-amd64.tar.gz') sha256='630177c6ad011193987904f09ffafec29d531abfeb5e43fa3714e376e5f28ddc' ;; \
		'prometheus-3.4.2.linux-arm64.tar.gz') sha256='6c4ba48d2efe582bd70c296a2184fbb1adf03c1cb3ef8e8b61bb009ed3d73c85' ;; \
		'prometheus-3.4.2.linux-armv5.tar.gz') sha256='b762ab3de2e6db7c315d69d27679f7fd38c180f0120289e25c4358917198ebc2' ;; \
		'prometheus-3.4.2.linux-armv6.tar.gz') sha256='d5999f3e4194abd55d6d268729b9612ba678b5330c6e8f502aca85fc1c02e175' ;; \
		'prometheus-3.4.2.linux-armv7.tar.gz') sha256='786561a46c98b1c58c63af8b5d0879e4e1f350a098a31343656122053e984ce4' ;; \
		'prometheus-3.4.2.linux-mips.tar.gz') sha256='e5c941b36111c7f334b87fb86efce9cb68fa7fde553e895b94794e40752de2c2' ;; \
		'prometheus-3.4.2.linux-mips64.tar.gz') sha256='0ffd1e9b50535590ffa5f4acebf91ecf6b82e53d9ff6ab449056c3d6f161a5ce' ;; \
		'prometheus-3.4.2.linux-mips64le.tar.gz') sha256='0b7329492dbdad0c79601d77709380a3ec66ae059d6852f50bddd80b8d734029' ;; \
		'prometheus-3.4.2.linux-mipsle.tar.gz') sha256='bc0f690503a0e439641823c5b2e46ce115a56c2dba06faa7dbd90df77150a408' ;; \
		'prometheus-3.4.2.linux-ppc64.tar.gz') sha256='a169e01e88018aeeab0d1d4170cb3484d62a4ce53dffe1915d0bb40b164765ae' ;; \
		'prometheus-3.4.2.linux-ppc64le.tar.gz') sha256='fa8659ec2218b3e9e0ff9af346b0da0fac93dc6c5fdf8d66e173293bdfa12f3f' ;; \
		'prometheus-3.4.2.linux-riscv64.tar.gz') sha256='fa04f6ec49d302c9ba298e95764fb5924b18314218f5ce91eda0e9353213accf' ;; \
		'prometheus-3.4.2.linux-s390x.tar.gz') sha256='521decf46567c5e8a2420563a03e8e4e2c0741510d54799bbedfe0b1299e83b1' ;; \
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
