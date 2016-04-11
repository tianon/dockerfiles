FROM alpine:3.3

RUN apk add --no-cache curl

ENV DOCKER_VERSION 1.11.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.11.0-dev.tgz
ENV DOCKER_SHA256 0197d651e392ab9011d611e5ba5e66c3117b41c8d5392675e94ac1ac9b744c60

RUN set -x \
	&& curl -fSL "${DOCKER_URL}" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
