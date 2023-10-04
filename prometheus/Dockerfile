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
ENV PROMETHEUS_VERSION 2.47.1

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
		'prometheus-2.47.1.linux-386.tar.gz') sha256='81bfff00399e74b32037af95b201f181ae980906238916ee8ab78d0a8fbe601e' ;; \
		'prometheus-2.47.1.linux-amd64.tar.gz') sha256='40d6db7305b11e645bb43d7f3f4025c6394743c0b9e4f3029db2db80198e37d4' ;; \
		'prometheus-2.47.1.linux-arm64.tar.gz') sha256='ef863fc12e3b7f781a3d3a676fbdefabe9611d894b60f30483d604ef6fdd505f' ;; \
		'prometheus-2.47.1.linux-armv5.tar.gz') sha256='c23853ea3a54aaa61bf562a376cdec7ee478aa427d69cbb09cc4fb3cdf0919a3' ;; \
		'prometheus-2.47.1.linux-armv6.tar.gz') sha256='478c3d46d97b82977aafd382d1652ef11163c4b1c9a0e4eaa6ac32f096d77f39' ;; \
		'prometheus-2.47.1.linux-armv7.tar.gz') sha256='7fac4a92d30e5fb54666c006a7277cbfb05bad42eeb8842c494f311bb59ce6c1' ;; \
		'prometheus-2.47.1.linux-mips.tar.gz') sha256='711e37cb6c370d85851da966a2dbfcca1c0c90b76e832e4c067ea9901cf7b29f' ;; \
		'prometheus-2.47.1.linux-mips64.tar.gz') sha256='90f97007300afca95a0ba0f05cf0af675276ee21338befd9681be3380071a9c4' ;; \
		'prometheus-2.47.1.linux-mips64le.tar.gz') sha256='3bc84c29e4f105a0442199b8c9df049ea67e4f57c7b49ef6b444c34839466409' ;; \
		'prometheus-2.47.1.linux-mipsle.tar.gz') sha256='1b496d7d100fc21b9a075f1998d10a797be5bc418ed7d3b2ef564a1ab12551dd' ;; \
		'prometheus-2.47.1.linux-ppc64.tar.gz') sha256='2c960b0d6c5f31438d1c4c6aa1e0a5ab16c20988dae00dac6e3167874712b8b1' ;; \
		'prometheus-2.47.1.linux-ppc64le.tar.gz') sha256='a27573603d48bed14ad7560dc94ba15fdd427fc86b44faee48bdfcc365306f38' ;; \
		'prometheus-2.47.1.linux-riscv64.tar.gz') sha256='8d4831b034bc1b8726d1574a61b2cb41d52d40c2b1b1610ebb4bbd9a36432873' ;; \
		'prometheus-2.47.1.linux-s390x.tar.gz') sha256='de1aec99686c48ad9eaef8b40593934206dc922a6c38767d74b85e13678b800d' ;; \
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
