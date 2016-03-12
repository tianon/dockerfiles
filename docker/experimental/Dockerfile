FROM alpine:3.2

RUN apk add --update \
		curl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.11.0-dev
ENV DOCKER_URL http://experimental.docker.com.s3.amazonaws.com/builds/Linux/x86_64/docker-1.11.0-dev
ENV DOCKER_SHA256 ddabd5bae28a3dbb86e20b44d9fd2463d5831bc47cc6d0264bf56fe5165c7181

RUN curl -fSL "${DOCKER_URL}" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
