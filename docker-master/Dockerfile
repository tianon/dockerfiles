FROM alpine:3.6

RUN apk add --no-cache \
		ca-certificates

ENV DOCKER_VERSION master-dockerproject-2017-10-04
ENV DOCKER_URL https://master.dockerproject.org/linux/x86_64/docker.tgz
ENV DOCKER_SHA256 5fc6ae0703290b1b3bf843f42b35ffc2913370dd87ad2b3ee7fffbb913506c14

RUN set -ex; \
	apk add --no-cache --virtual .fetch-deps \
		curl \
		tar \
	; \
	curl -fL -o docker.tgz "${DOCKER_URL}"; \
	\
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	rm docker.tgz; \
	\
	apk del .fetch-deps; \
	\
	dockerd -v; \
	docker -v

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
