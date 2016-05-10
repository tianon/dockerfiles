FROM alpine:3.3

RUN apk add --no-cache curl

ENV DOCKER_VERSION 1.12.0-dev
ENV DOCKER_URL http://experimental.docker.com.s3.amazonaws.com/builds/Linux/x86_64/docker-1.12.0-dev.tgz
ENV DOCKER_SHA256 20129dcd8f7be353b0bf3543c3d6efba0fdec8f177f1ee0dc2b5506afffb5a5d

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
