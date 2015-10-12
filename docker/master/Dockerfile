FROM alpine:3.2

RUN apk add --update \
		curl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.9.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.9.0-dev
ENV DOCKER_SHA256 c987ba8c819fe71e84721aadf1e3be71f96ae2d2dad7154751ad89f9adc5ca07

RUN curl -fSL "${DOCKER_URL}" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
