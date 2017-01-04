FROM alpine:3.4

WORKDIR /opt/node-exporter
ENV PATH /opt/node-exporter:$PATH

ENV NODE_EXPORTER_VERSION 0.12.0

RUN set -ex; \
	\
	apk add --no-cache --virtual .fetch-deps \
		ca-certificates \
		openssl \
		tar \
	; \
	\
	wget -O /tmp/node-exporter.tar.gz "https://github.com/prometheus/node_exporter/releases/download/${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"; \
	tar \
		--extract \
		--file /tmp/node-exporter.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/node-exporter.tar.gz; \
	\
	node_exporter -version; \
	\
	apk del .fetch-deps

VOLUME /opt/node-exporter/data

EXPOSE 9100
CMD ["node_exporter"]
