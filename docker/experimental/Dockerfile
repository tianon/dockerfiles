FROM alpine:3.2

RUN apk add --update \
		curl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.10.0-dev
ENV DOCKER_URL http://experimental.docker.com.s3.amazonaws.com/builds/Linux/x86_64/docker-1.10.0-dev
ENV DOCKER_SHA256 2ea33b91c66b32b197428cb122d3e30cb29884a57da5f07cbd138a462a303043

RUN curl -fSL "${DOCKER_URL}" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
