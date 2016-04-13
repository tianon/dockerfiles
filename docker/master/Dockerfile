FROM alpine:3.3

RUN apk add --no-cache curl

ENV DOCKER_VERSION 1.11.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.11.0-dev.tgz
ENV DOCKER_SHA256 55d7b9a3e22faafc16abf2a8e3cf0c6e3803cd995ea880da77fa3d5384c07b61

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
