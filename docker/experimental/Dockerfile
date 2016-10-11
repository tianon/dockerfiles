FROM alpine:3.4

RUN apk add --no-cache \
		ca-certificates \
		curl \
		openssl

ENV DOCKER_VERSION 1.12.2
ENV DOCKER_URL http://experimental.docker.com.s3.amazonaws.com/builds/Linux/x86_64/docker-1.12.2.tgz
ENV DOCKER_SHA256 a4450d76587d8a9f27cf21d8e373ae5efa75297ab92b81d77e726f88a4b6a534

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
