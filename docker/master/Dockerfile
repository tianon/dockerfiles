FROM alpine:3.2

RUN apk add --update \
		curl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.11.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.11.0-dev
ENV DOCKER_SHA256 cf89a76055064c0173728b0d8c17bba157f031c52ef9427acad6388c2883fb6b

RUN curl -fSL "${DOCKER_URL}" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
