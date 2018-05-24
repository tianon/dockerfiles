FROM alpine:3.6

RUN apk add --no-cache \
		ca-certificates

ENV DOCKER_VERSION master-dockerproject-2018-05-23
ENV DOCKER_URL https://master.dockerproject.org/linux/x86_64/docker.tgz
ENV DOCKER_SHA256 b49eb611de78823c1d2ed136252aaf2d31debf5fd5759f95c43e088af3fe7eea

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
