FROM alpine:3.6

RUN apk add --no-cache \
		ca-certificates

ENV DOCKER_VERSION 17.06.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/x86_64/docker-17.06.0-dev.tgz
ENV DOCKER_SHA256 ce126ddc078aca07f7218e8cd64597e881df15ed8ef2ea8793ce672b0107d4a6

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
