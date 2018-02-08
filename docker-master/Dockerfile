FROM alpine:3.6

RUN apk add --no-cache \
		ca-certificates

ENV DOCKER_VERSION master-dockerproject-2018-02-07
ENV DOCKER_URL https://master.dockerproject.org/linux/x86_64/docker.tgz
ENV DOCKER_SHA256 81d2ee4186a664e8c1d38acb308a38a02d5c2389115fc9c526e74947e7796fde

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
