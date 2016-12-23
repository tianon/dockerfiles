FROM alpine:3.4

RUN apk add --no-cache \
		ca-certificates \
		curl \
		openssl

ENV DOCKER_VERSION 1.14.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.14.0-dev.tgz
ENV DOCKER_SHA256 f632b0f7e5a2b0fbb8405817c3ca0568630c31a81b32002d16b9bdb9b633c987

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
