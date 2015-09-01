FROM alpine:3.2

RUN apk add --update \
		ca-certificates \
		openssl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.9.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.9.0-dev
ENV DOCKER_SHA256 86e0c0fea811d0f8348bbd622281cfbee07958c185a0e8545d0875e3407b6922

RUN wget "${DOCKER_URL}" -O /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
