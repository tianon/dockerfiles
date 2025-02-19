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
ENV PROMETHEUS_VERSION 3.2.0

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
		'prometheus-3.2.0.linux-386.tar.gz') sha256='cd463b8837c8fc019b669f1fd71174f8dc90e7592db75c41e4c838547898c765' ;; \
		'prometheus-3.2.0.linux-amd64.tar.gz') sha256='20e1ee6b14f65897c0378a507ad1a57f500a3aa79a64ba427d80b7efe432f667' ;; \
		'prometheus-3.2.0.linux-arm64.tar.gz') sha256='3531b2e466f1b6cf21463e21e07ab4e25e606c172a1782b3aff28b7a62905744' ;; \
		'prometheus-3.2.0.linux-armv5.tar.gz') sha256='2a2b3411d1afbb1bf831b85d6b2fe899341b8ebdcf66d9eedc384a31744a150d' ;; \
		'prometheus-3.2.0.linux-armv6.tar.gz') sha256='461fcb596b8906eb0543055f8d2aebc805f5325152d2c89333442dc348c0cd10' ;; \
		'prometheus-3.2.0.linux-armv7.tar.gz') sha256='6f0bef048331f0a491eb2f0b9deb1a5bd35ec1dbffcd99f522b14f213afdb943' ;; \
		'prometheus-3.2.0.linux-mips.tar.gz') sha256='2ec33596244985fd34624aeab724cd24482e8c0d0c40fc78765d1ff34230c686' ;; \
		'prometheus-3.2.0.linux-mips64.tar.gz') sha256='a23dfb9154dd0a753f0ee7456c9ce6ed755fdace6f21754ddf7295e3a1b7324e' ;; \
		'prometheus-3.2.0.linux-mips64le.tar.gz') sha256='d55a2e4df5e7364053af2ffaa7eea59c20d0577a05a04c568abae823ef9ad3a8' ;; \
		'prometheus-3.2.0.linux-mipsle.tar.gz') sha256='8fee57660302316118bf50a2e8bcc8e83d55402f975f0838358d36021e8be35e' ;; \
		'prometheus-3.2.0.linux-ppc64.tar.gz') sha256='5255099c5378bcab8cfb9ffdf61e437a023c378a70ada01f0ca2330d5500415d' ;; \
		'prometheus-3.2.0.linux-ppc64le.tar.gz') sha256='331aae6e36d9b677358860829b35c929753832fa29a7282a4f4c47e8e77feef3' ;; \
		'prometheus-3.2.0.linux-riscv64.tar.gz') sha256='3de4f2f6e9b008b8c4b3d89690a62b52f0b7273bad1920bb88a285b9ac1e3d46' ;; \
		'prometheus-3.2.0.linux-s390x.tar.gz') sha256='53b146a2e38c44a2b6879f8ca3c8a3472186fda0a5fb7eec40474da2e7c8351b' ;; \
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
