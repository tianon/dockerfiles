FROM alpine:3.2

RUN apk add --update \
		ca-certificates \
		openssl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.9.0-dev
ENV DOCKER_URL https://experimental.docker.com/builds/Linux/x86_64/docker-1.9.0-dev
ENV DOCKER_SHA256 ce7711c00a55438b89ede9a210b7710d107f97547dbee707fb3357cb53345f62  docker-1.9.0-dev

RUN wget "${DOCKER_URL}" -O /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
