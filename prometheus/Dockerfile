#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 2.51.1

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
		'prometheus-2.51.1.linux-386.tar.gz') sha256='45f93954f7d3924a0f672de7cd78f8cdd26554c8547cce29b130ebac59b6d46b' ;; \
		'prometheus-2.51.1.linux-amd64.tar.gz') sha256='1f933ea7515e3a6e60374ee0bfdb62bc4701c7b12c1dbafe1865c327c6e0e7d2' ;; \
		'prometheus-2.51.1.linux-arm64.tar.gz') sha256='f281f674f2e7fb726a6066585197780f63bce8455a1773ec498b5be0c8732eb5' ;; \
		'prometheus-2.51.1.linux-armv5.tar.gz') sha256='b9ae366ebfdde572c634e7fede3d7f310ef8cbf3867449ca0f078ea62e760347' ;; \
		'prometheus-2.51.1.linux-armv6.tar.gz') sha256='3cf6cc353f7f45d82f4761f7b527507ba93fdaa4e13c08b92e47347b7061c46a' ;; \
		'prometheus-2.51.1.linux-armv7.tar.gz') sha256='c4dba2f1bf70aaed7ee455cc0828b0229a74ed85f8d6e5ce623798bdef10c130' ;; \
		'prometheus-2.51.1.linux-mips.tar.gz') sha256='592ce56fda617c8130acc58ce9a6d9375d976404eaf5150a903b417b7eae772d' ;; \
		'prometheus-2.51.1.linux-mips64.tar.gz') sha256='cafdbc46e7abd0c15de8853e6b5c5fc4715be72859dd4b980bb8d208746e7524' ;; \
		'prometheus-2.51.1.linux-mips64le.tar.gz') sha256='4e47fe5abf804edd0038906923e767817fbfefd99ea759086c398448f722d062' ;; \
		'prometheus-2.51.1.linux-mipsle.tar.gz') sha256='f3de2436b5979a98abe73c174bb2ed47d8defc21e1c3033eea3de939394143d7' ;; \
		'prometheus-2.51.1.linux-ppc64.tar.gz') sha256='cd7439a8bdc6568c060bb6dbae6ffe40116e9ea99924ced29130d0171d94f481' ;; \
		'prometheus-2.51.1.linux-ppc64le.tar.gz') sha256='b02493202d17440ab4f1e2f16ed90f3243894c288621fd5766b0a105c90c520e' ;; \
		'prometheus-2.51.1.linux-riscv64.tar.gz') sha256='f5b10729452763b9c770276806d71fb581fc737741ef869ae91f71b1619224e5' ;; \
		'prometheus-2.51.1.linux-s390x.tar.gz') sha256='062bde62cd5506947a4756316838ece20a8456eab6b2ab14a25b327f0c403864' ;; \
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
