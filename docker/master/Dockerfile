FROM alpine:3.2

RUN apk add --update \
		curl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.9.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.9.0-dev
ENV DOCKER_SHA256 1779a93d41d6777046688ade3cfd49869efc32cdce709e999b0a12102a8beaea

RUN curl -fSL "${DOCKER_URL}" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
