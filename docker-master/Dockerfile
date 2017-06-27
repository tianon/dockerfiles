FROM alpine:3.5

RUN apk add --no-cache \
		ca-certificates \
		curl \
		openssl

ENV DOCKER_VERSION 17.06.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/x86_64/docker-17.06.0-dev.tgz
ENV DOCKER_SHA256 505fffa227785f963ec20a9e766f7af700d3046c6277059ff426ba6360f0d56a

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
