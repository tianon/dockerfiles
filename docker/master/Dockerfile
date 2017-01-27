FROM alpine:3.4

RUN apk add --no-cache \
		ca-certificates \
		curl \
		openssl

ENV DOCKER_VERSION 1.14.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.14.0-dev.tgz
ENV DOCKER_SHA256 4395179f710e63e2c0ea1e302383c3a8367e3fcb6043acf77bfc708f266c9082

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
