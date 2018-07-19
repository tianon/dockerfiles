FROM alpine:3.8

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

ENV NODE_EXPORTER_VERSION 0.16.0

RUN set -ex; \
	\
	apk add --no-cache --virtual .fetch-deps \
		ca-certificates \
		libressl \
	; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) promArch='arm64'   ;; \
		armhf)   promArch='armv6'   ;; \
		x86)     promArch='386'     ;; \
		x86_64)  promArch='amd64'   ;; \
		*) echo >&2 "error: unsupported arch: $apkArch"; exit 1 ;; \
	esac; \
	\
	wget -O /tmp/node-exporter.tar.gz "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-$promArch.tar.gz"; \
	tar \
		--extract \
		--file /tmp/node-exporter.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/node-exporter.tar.gz; \
	\
	node_exporter --version; \
	\
	apk del .fetch-deps

VOLUME /opt/node-exporter/data

EXPOSE 9100
CMD ["node_exporter"]
