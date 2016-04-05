FROM alpine:3.2

RUN apk add --update \
		curl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.11.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.11.0-dev
ENV DOCKER_SHA256 0dd45aeb8ae965ed1fcc558050f60d90889ac982de2a1e50579be00800fc5991

RUN curl -fSL "${DOCKER_URL}" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
