FROM alpine:3.3

RUN apk add --no-cache curl

ENV DOCKER_VERSION 1.12.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.12.0-dev.tgz
ENV DOCKER_SHA256 4cb29f0928595986ff4bdbb990c4db76db0e3428062008e9f6678107b10a2944

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
