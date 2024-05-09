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
ENV PROMETHEUS_VERSION 2.52.0

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
		'prometheus-2.52.0.linux-386.tar.gz') sha256='ce9fa8370a82a64f1172d43f4cecc383d4d82b7b40bfbeaf7fe81aa5503af95e' ;; \
		'prometheus-2.52.0.linux-amd64.tar.gz') sha256='7f31c5d6474bbff3e514e627e0b7a7fbbd4e5cea3f315fd0b76cad50be4c1ba3' ;; \
		'prometheus-2.52.0.linux-arm64.tar.gz') sha256='b503c0f552e381d7d3f84dfd275166bf07c74f99c428ffed69447d4ab3259901' ;; \
		'prometheus-2.52.0.linux-armv5.tar.gz') sha256='f3f95d88afe09fd147b8c77ecc75303950c5cf57ca6b9aad4cbad342f6d38025' ;; \
		'prometheus-2.52.0.linux-armv6.tar.gz') sha256='c5034daa9ead78532557080a2ce5abddb5d9ad2f45faf37e3e9eb530ecf949d4' ;; \
		'prometheus-2.52.0.linux-armv7.tar.gz') sha256='6bf7c4688e97f2f5cae0537a1c81efbfc92256041c94e04f974fb0a3152b9ede' ;; \
		'prometheus-2.52.0.linux-mips.tar.gz') sha256='e9a09fe0c175649bb78b71f0e085467b33d7ff597fec15f8911c042206bd8964' ;; \
		'prometheus-2.52.0.linux-mips64.tar.gz') sha256='685d80a17d42e59c94d332d24319f574fea10133d1def6d8f5b91120b7c6d18f' ;; \
		'prometheus-2.52.0.linux-mips64le.tar.gz') sha256='68a503c0fa1586632f0d983e028c1c73faf4b130e88ead4ad39633a7e448ffb7' ;; \
		'prometheus-2.52.0.linux-mipsle.tar.gz') sha256='8765df4454822aa63547cc9e19974a7ff21647150de157ce23bcbf867528980d' ;; \
		'prometheus-2.52.0.linux-ppc64.tar.gz') sha256='a77b0cc9159e54799f93f7956ee4782b7261c0a434a191a16cf98541ee9696f4' ;; \
		'prometheus-2.52.0.linux-ppc64le.tar.gz') sha256='5724e630f7f6c242f1f0cc78ba486347a225973947e014709fa9ae6e05ed357c' ;; \
		'prometheus-2.52.0.linux-riscv64.tar.gz') sha256='ffcad855e91e9d572c86cb58de38ce8685ba7d63d9cf0f47c8e396c6211affbc' ;; \
		'prometheus-2.52.0.linux-s390x.tar.gz') sha256='20db798e6dd41d53015218cb3c03d0d1a54e6421854bcc61d1a0ec93dd982250' ;; \
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
