FROM alpine:3.5

RUN apk add --no-cache \
		ca-certificates \
		curl \
		openssl

ENV DOCKER_VERSION 17.05.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-17.05.0-dev.tgz
ENV DOCKER_SHA256 0db1261e838257704086a6cc5b7973780144564863bc78f53741e8ac19ff93bb

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
