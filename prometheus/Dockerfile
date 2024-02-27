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
ENV PROMETHEUS_VERSION 2.50.1

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
		'prometheus-2.50.1.linux-386.tar.gz') sha256='3440c7858711ca55242fcb055f563db6ad9fb7e9b0b89869cf35d5bef36f211c' ;; \
		'prometheus-2.50.1.linux-amd64.tar.gz') sha256='936f3777f8c3a4a90d3c58a6f410350d5932c79367b99771d002bd36e48bd05b' ;; \
		'prometheus-2.50.1.linux-arm64.tar.gz') sha256='9f1a65cf08cef3dcd5f0d38d8673ecfaf1054aa9e1e5c18c94efd8546c1fdd96' ;; \
		'prometheus-2.50.1.linux-armv5.tar.gz') sha256='03e744703509ffe67b46d009522ccfa99734bc6c84acf10ae70453e78507c4b6' ;; \
		'prometheus-2.50.1.linux-armv6.tar.gz') sha256='954b79ef1a78c405d35d712d936681831bbfc6ca78c1b2bf9f7c8d6bf6f51194' ;; \
		'prometheus-2.50.1.linux-armv7.tar.gz') sha256='3ec3073dec3dfd874ebe74620b6ed1dc9a030379cdff46ad816a6e95b85316d8' ;; \
		'prometheus-2.50.1.linux-mips.tar.gz') sha256='1162e8601aba93aa2063bf44611e945e0fa401cbd4a4adb63a26ca3763ab2101' ;; \
		'prometheus-2.50.1.linux-mips64.tar.gz') sha256='10685c720fc2c3e368b3a37b71a99fba02e67d1a730c017c28b1e35297b14681' ;; \
		'prometheus-2.50.1.linux-mips64le.tar.gz') sha256='7e2c949a90e1e0e2f824bbe6889dc2e689aad570ebc08d60c1f279f0c135a6e3' ;; \
		'prometheus-2.50.1.linux-mipsle.tar.gz') sha256='eddc91eabf67badddc1fa3b8e85f66e28fe326f7693d5ee37acd05a37d6fc958' ;; \
		'prometheus-2.50.1.linux-ppc64.tar.gz') sha256='c63b2681d4299302c710686ae57d125c09f54f821681463fa2d60c86b477b396' ;; \
		'prometheus-2.50.1.linux-ppc64le.tar.gz') sha256='82c83fdc3eca057e910f9c152bfc03cccc2198828f9b5f1e1b2981d660931fd6' ;; \
		'prometheus-2.50.1.linux-riscv64.tar.gz') sha256='2c0f6ca41b6d79806cf27879797bf9bde1fbd196a16cc927caa8ed707f1a2ff7' ;; \
		'prometheus-2.50.1.linux-s390x.tar.gz') sha256='cf3342e1cd49e55d1a3f9e03c280bb264ffc0fba7a69ea1f285d73e027a858e4' ;; \
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
