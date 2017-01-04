FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /opt/grafana
ENV PATH /opt/grafana/bin:$PATH

ENV GRAFANA_VERSION 3.1.1-1470047149

RUN set -ex; \
	\
	wget -O /tmp/grafana.tar.gz "https://grafanarel.s3.amazonaws.com/builds/grafana-${GRAFANA_VERSION}.linux-x64.tar.gz"; \
	tar \
		--extract \
		--file /tmp/grafana.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/grafana.tar.gz; \
	\
	grafana-server -v

VOLUME /opt/grafana/data

EXPOSE 3000
CMD ["grafana-server"]
