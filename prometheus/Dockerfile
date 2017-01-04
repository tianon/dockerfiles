FROM alpine:3.4

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

ENV PROM_VERSION 1.2.1

RUN set -ex; \
	\
	apk add --no-cache --virtual .fetch-deps \
		ca-certificates \
		openssl \
		tar \
	; \
	\
	wget -O /tmp/prom.tar.gz "https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz"; \
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
