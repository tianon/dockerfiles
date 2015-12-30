FROM alpine:3.2

RUN apk add --update \
		curl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.10.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.10.0-dev
ENV DOCKER_SHA256 d5cf173cee18fcfa3b5fc2a4cd1170621d697e052588bd33ef6ade42f9ec3c6c

RUN curl -fSL "${DOCKER_URL}" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
