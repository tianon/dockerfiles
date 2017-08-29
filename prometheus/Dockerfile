FROM alpine:3.6

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

ENV PROMETHEUS_VERSION 1.2.1

RUN set -ex; \
	\
	apk add --no-cache --virtual .fetch-deps \
		ca-certificates \
		libressl \
	; \
	\
	wget -O /tmp/prom.tar.gz "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"; \
	tar \
		--extract \
		--file /tmp/prom.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/prom.tar.gz; \
	\
	prometheus -version; \
	\
	apk del .fetch-deps

VOLUME /opt/prometheus/data

EXPOSE 9090
CMD ["prometheus"]
