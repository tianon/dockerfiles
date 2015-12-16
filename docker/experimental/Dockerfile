FROM alpine:3.2

RUN apk add --update \
		curl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.10.0-dev
ENV DOCKER_URL https://experimental.docker.com/builds/Linux/x86_64/docker-1.10.0-dev
ENV DOCKER_SHA256 9ec9d7cae3d46b47b17c484b612bfa2c2cd071b7a1bb89545bd4163facff8a1f

RUN curl -fSL "${DOCKER_URL}" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
