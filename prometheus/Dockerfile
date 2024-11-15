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
ENV PROMETHEUS_VERSION 3.0.0

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
		'prometheus-3.0.0.linux-386.tar.gz') sha256='2a4653a58520df0090cd7dfb8342418573b5a137d96e9ff70449b8ee04c60943' ;; \
		'prometheus-3.0.0.linux-amd64.tar.gz') sha256='614ce24f4802f1a2d3dc35ab9bd35047f428469c7e029163602a40078bf7508b' ;; \
		'prometheus-3.0.0.linux-arm64.tar.gz') sha256='b2e6947d5fad863c89f56cee8047e8f57b63fde6b41c918300e1e88c1c62d1b5' ;; \
		'prometheus-3.0.0.linux-armv5.tar.gz') sha256='3b34c6137f321c5709fa8ae15e88330a8f61d04cc07b278755435947a4a10dac' ;; \
		'prometheus-3.0.0.linux-armv6.tar.gz') sha256='4e68d71e6d4f9f1f6955fb1045d7ab6b0f7e2272bd713448e8e3003872409549' ;; \
		'prometheus-3.0.0.linux-armv7.tar.gz') sha256='e97e9c9bbc86e2972de9f5db0ac1036e950784316cc0ba70a6fc0b3852cccef5' ;; \
		'prometheus-3.0.0.linux-mips.tar.gz') sha256='fd3e9c6d1577be809280388605d9f6b99ad42f3456c68d253d5b0d6f5be392fa' ;; \
		'prometheus-3.0.0.linux-mips64.tar.gz') sha256='7c60f401406bd227a1ffbc9ea2a388d4c417f3c61b8ef77a91e86a1c2e6d318a' ;; \
		'prometheus-3.0.0.linux-mips64le.tar.gz') sha256='5139e815ff8ddf6d0e783c93f988653965dc75af6900c7d4276762f4e7bfefcc' ;; \
		'prometheus-3.0.0.linux-mipsle.tar.gz') sha256='071a072f768353c23e2facc2b0e0f5a036a2ff9bc56e7079a5a1e127ffc0161f' ;; \
		'prometheus-3.0.0.linux-ppc64.tar.gz') sha256='7376e0c49fd6f996b861c2f9b2323f3dddf4dc93f2e4f24943410a5a6eb718e0' ;; \
		'prometheus-3.0.0.linux-ppc64le.tar.gz') sha256='ce0e3916bba69f07d5ffb4b31f5c575f398d8eff008bd184140539662fb7d6d1' ;; \
		'prometheus-3.0.0.linux-riscv64.tar.gz') sha256='49ee1f340eaa7611abed1d4ef39eb43be4afaf1d9a015f57b4580fe804477e5e' ;; \
		'prometheus-3.0.0.linux-s390x.tar.gz') sha256='90823fb93d587ed0e86e5b02582d9ce5377471f2d3925bdbe1bccd6009237c36' ;; \
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
