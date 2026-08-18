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
ENV PROMETHEUS_VERSION 3.14.0

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
		'prometheus-3.14.0.linux-386.tar.gz') sha256='9e0bcc54d4c0f574d7d1c5168014b565bdc5dbbc118f33cf5cc4630f39e1664f' ;; \
		'prometheus-3.14.0.linux-amd64.tar.gz') sha256='f665c6da19eb7ba399c915d30c7d9793c9b417bf8a749b504bc470678631478d' ;; \
		'prometheus-3.14.0.linux-arm64.tar.gz') sha256='077f3781ab7245dc04c9a3c9b78ba120fc8e41aa0dc97489b0af67247e50ba83' ;; \
		'prometheus-3.14.0.linux-armv5.tar.gz') sha256='349155cbba19bfc1bb15d1eb9415a8e615fa873765d4a65e86d668cf83425cad' ;; \
		'prometheus-3.14.0.linux-armv6.tar.gz') sha256='fa572d0615e0682376e72268012d432d2231bdf3672d3592cc4c310519932237' ;; \
		'prometheus-3.14.0.linux-armv7.tar.gz') sha256='60f9251e84b0f5f9cb2c0d29d92dd0fd7c0dd98c946d781915c3c27e592c1d3a' ;; \
		'prometheus-3.14.0.linux-mips.tar.gz') sha256='d53a14ee6ca2e744cb6269c24208395e1ba53ded01a30a0c9ed43d5cd671efb4' ;; \
		'prometheus-3.14.0.linux-mips64.tar.gz') sha256='9c57091799449e0ec89c34b82cace930c9c5412db32a3ad6eafe0d0e89dfa70a' ;; \
		'prometheus-3.14.0.linux-mips64le.tar.gz') sha256='64075ec9c5a62561bd8ffc227e4bfa6b5301a06b123063b1ef964a3470926f3f' ;; \
		'prometheus-3.14.0.linux-mipsle.tar.gz') sha256='f624441af68e05b0b8f3eef6da3ebb92babea1162fea8e583423bb249f31fb9b' ;; \
		'prometheus-3.14.0.linux-ppc64.tar.gz') sha256='4df6d5daa0758a4cd5f970966837f45d1cb5386c16dc99753b70dbd25f75041a' ;; \
		'prometheus-3.14.0.linux-ppc64le.tar.gz') sha256='a4313ea97b1682d942202d5ea98f016e318304a50c08b0d70f4937e07403aad3' ;; \
		'prometheus-3.14.0.linux-riscv64.tar.gz') sha256='ce149d526c5db22c88f991687186ce1f5406261a9d74f4f35b085ab501fc7c3d' ;; \
		'prometheus-3.14.0.linux-s390x.tar.gz') sha256='259f2f21081efd0d7b2e0e881ee780c398105670b409d6f62bfa8833618a9758' ;; \
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
