FROM alpine:3.4

RUN apk add --no-cache \
		ca-certificates \
		curl \
		openssl

ENV DOCKER_VERSION 17.04.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-17.04.0-dev.tgz
ENV DOCKER_SHA256 1d74ab6b0b9a411c55aa16500d50fe3b9588f4ee71c2f80867e9fe616c32302b

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
