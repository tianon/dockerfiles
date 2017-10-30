FROM alpine:3.6

RUN apk add --no-cache \
		ca-certificates

ENV DOCKER_VERSION master-dockerproject-2017-10-29
ENV DOCKER_URL https://master.dockerproject.org/linux/x86_64/docker.tgz
ENV DOCKER_SHA256 940883849e5b7fdc42a28f2471d2813f92783ff619f3cfaab97ffa83d5c3b92c

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
