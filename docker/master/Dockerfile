FROM alpine:3.3

RUN apk add --no-cache curl

ENV DOCKER_VERSION 1.12.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.12.0-dev.tgz
ENV DOCKER_SHA256 ead20a2c4208efbc17fac32896e1e72fa8c00b8f05173f084eae45f3ff96ee56

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
