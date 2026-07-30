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
ENV PROMETHEUS_VERSION 3.13.2

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
		'prometheus-3.13.2.linux-386.tar.gz') sha256='44893279b08517c12a495283eded1fee31bbee9b7c0ce6e8a1e8c340f5bb25ab' ;; \
		'prometheus-3.13.2.linux-amd64.tar.gz') sha256='0e8c4d46101bd025ea8265e377d2caabc57f488fc1be1c367f37db69ea41be6f' ;; \
		'prometheus-3.13.2.linux-arm64.tar.gz') sha256='7cecb17a6f41d59814e1a0581a1f81f79051ad5973d1ecf39e23a9f747d6572a' ;; \
		'prometheus-3.13.2.linux-armv5.tar.gz') sha256='594bfa6d20dfa50ffdbffa7308ef7116dc9d4a6779bd5c053f5148544b62bd30' ;; \
		'prometheus-3.13.2.linux-armv6.tar.gz') sha256='bfa444e4ba713cde51fbe3e5738f4ad043529f41c4c6489a6a45ef0322d614e7' ;; \
		'prometheus-3.13.2.linux-armv7.tar.gz') sha256='e5dacfd3968831e83eb4aea501ff6b6e00e6cdb1aa8a8b3b9675bedf5d1a3867' ;; \
		'prometheus-3.13.2.linux-mips.tar.gz') sha256='0ba68d3214b5cdd4e2e355f46afe9eb757d27cb1973fba62dade72ab6bd9178d' ;; \
		'prometheus-3.13.2.linux-mips64.tar.gz') sha256='f6ec5bcdb53607f93b5ced2906cf9327884f613bad95bc60213dccb42cc52100' ;; \
		'prometheus-3.13.2.linux-mips64le.tar.gz') sha256='4c57a9ff75977a53c6cb7cdfae87700d3eb09d092d5d885249af147aaf518059' ;; \
		'prometheus-3.13.2.linux-mipsle.tar.gz') sha256='3ea9fe219c1a15c9b44a10e74a4897d68f6ae980b3e4b069e5f029e3afdb3c07' ;; \
		'prometheus-3.13.2.linux-ppc64.tar.gz') sha256='b20a48fc501aa4c57004f29fb0c8609bddfe6a57ac87c1f07b7b7d86cacc4cbb' ;; \
		'prometheus-3.13.2.linux-ppc64le.tar.gz') sha256='fe48f7c6a0b4d6c18d1f3165fb3b34d6fd15ab3746d9c1bd8262bb18c139ec65' ;; \
		'prometheus-3.13.2.linux-riscv64.tar.gz') sha256='f719caf863c540f54459b7b8a6d7e0617d16aa0a9966b3e7729cc249b23eeca6' ;; \
		'prometheus-3.13.2.linux-s390x.tar.gz') sha256='9b0a3426fb145e6093707cca6756bb12f53d5922ce60c35f90d6f1e4c89f3fd2' ;; \
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
