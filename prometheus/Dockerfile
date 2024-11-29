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
ENV PROMETHEUS_VERSION 3.0.1

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
		'prometheus-3.0.1.linux-386.tar.gz') sha256='c7254094c03f259e5138f0b5bfe51249b242b04c002bb906ec79394323c8f6bb' ;; \
		'prometheus-3.0.1.linux-amd64.tar.gz') sha256='43f6f228ef59e0c2f6994e489c5c76c6671553eaa99ded0aea1cd31366222916' ;; \
		'prometheus-3.0.1.linux-arm64.tar.gz') sha256='58e8d4f3ab633528fa784740409c529f4a434f8a0e3cf4d2f56e75ce2db69aa8' ;; \
		'prometheus-3.0.1.linux-armv5.tar.gz') sha256='517ffe6d74c1d875d6ff70df87640f26b1ac9f92e2f7fba80932cfa8eb6d7b8f' ;; \
		'prometheus-3.0.1.linux-armv6.tar.gz') sha256='8bce8e51d782087a2f99389bedff49035d25b7eb3690631e37ab362eb5952e7b' ;; \
		'prometheus-3.0.1.linux-armv7.tar.gz') sha256='7291dd21d2255e06c030b979eb0bd965ebc69f7cfa96c7c5b2b674ba5dcf63d5' ;; \
		'prometheus-3.0.1.linux-mips.tar.gz') sha256='f78520b93e8a4186649a75a3df0e340c348c82b7fb9711c88bb2c23e78ea761c' ;; \
		'prometheus-3.0.1.linux-mips64.tar.gz') sha256='91efe9741bf780970ffc0ba6b871b169cf2f131adf4357e60f73faf203bf1d9a' ;; \
		'prometheus-3.0.1.linux-mips64le.tar.gz') sha256='af8df9f2cdd93cda2261a4dd44ccfa4bc84c3f3ce886e91d527c0151dd0948bc' ;; \
		'prometheus-3.0.1.linux-mipsle.tar.gz') sha256='222666f762f02fdd5182d8a39590168f5208fd530aa8bf5573920406ace0cb74' ;; \
		'prometheus-3.0.1.linux-ppc64.tar.gz') sha256='43ed4755aad1977f9119eaa3ccf124d693ee24d56a5e1c70797a703107e0c1a2' ;; \
		'prometheus-3.0.1.linux-ppc64le.tar.gz') sha256='16fe327b691d43e9b2e7ae5a7047db8a2b0bb651b3bf5665113b184fa29e4d06' ;; \
		'prometheus-3.0.1.linux-riscv64.tar.gz') sha256='3fda6fc891ac12b323c6a4cec72d40bbe6e2d0f9f6864c4beb2213f03a5d2063' ;; \
		'prometheus-3.0.1.linux-s390x.tar.gz') sha256='e5422cad325d6cc83f4fee22159a2ae30582f1332243365e29c1fd34c4500798' ;; \
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
