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
ENV PROMETHEUS_VERSION 3.5.0

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
		'prometheus-3.5.0.linux-386.tar.gz') sha256='9c080bdb96e7d301abeb83376128ca34c36454e0137a48483ee7928a5fd7578d' ;; \
		'prometheus-3.5.0.linux-amd64.tar.gz') sha256='e811827af26d822afb09a4f28314f61b618b12cff5369835a67f674d8b46f39a' ;; \
		'prometheus-3.5.0.linux-arm64.tar.gz') sha256='173389cc42bf09c4e6e54cb53fa07a5a835d7c261e14775d2183181d6e385d1c' ;; \
		'prometheus-3.5.0.linux-armv5.tar.gz') sha256='4f2eda2c7cab09f2c17c1d15bc79e1889a2cc490d23a468cd2b40459230e1ae8' ;; \
		'prometheus-3.5.0.linux-armv6.tar.gz') sha256='4972f93a057b3565f997236d7b7199cb9fb4afe310ee7808dd52825676c78dda' ;; \
		'prometheus-3.5.0.linux-armv7.tar.gz') sha256='d725dfd058e8c52ea5052c823325d7bccf93fe9e4c90930edc751d9a0097618b' ;; \
		'prometheus-3.5.0.linux-mips.tar.gz') sha256='6ad690c99eaea082ce35a08b6aad84c1612de56f87fc148faa4fd4502ac707d8' ;; \
		'prometheus-3.5.0.linux-mips64.tar.gz') sha256='1579111e6fdaecaf86a98308b0fbe6d7e26cdb4dd1ef9c250ea6423d11f675ea' ;; \
		'prometheus-3.5.0.linux-mips64le.tar.gz') sha256='8b0c64146d814d9152f6a33dd489784f5aa71ddc2f030d8faaffe0ff4625740f' ;; \
		'prometheus-3.5.0.linux-mipsle.tar.gz') sha256='067a1cecf8c5aee09252e7699f97117b7de653b3a1567cfc2e4e7123647d5f5a' ;; \
		'prometheus-3.5.0.linux-ppc64.tar.gz') sha256='11849e343aeef0a911a0b76b709e603dd5bee5e80d8d764c987dc81bf602de3e' ;; \
		'prometheus-3.5.0.linux-ppc64le.tar.gz') sha256='fd902ac0d571cb2006849b0c730315f84cb16927fb9626d8eb49e53d676db3b7' ;; \
		'prometheus-3.5.0.linux-riscv64.tar.gz') sha256='170394dbb71f995a94300d61f1a72455734b7d20912d718632aa1203c9443313' ;; \
		'prometheus-3.5.0.linux-s390x.tar.gz') sha256='ad0c280a054950e4c6b1b36ae6acf78f8feb9ddc61ccbdc3e016875fbe1efef1' ;; \
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
