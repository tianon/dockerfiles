FROM alpine:3.5

RUN apk add --no-cache \
		ca-certificates \
		curl \
		openssl

ENV DOCKER_VERSION 17.05.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-17.05.0-dev.tgz
ENV DOCKER_SHA256 5206b65e7c35276b125961dc1768495531e759836a5a30f91afa70b281566034

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
