FROM alpine:3.2

RUN apk add --update \
		ca-certificates \
		openssl \
	&& rm -rf /var/cache/apk/*

ENV DOCKER_VERSION 1.9.0-dev
ENV DOCKER_URL https://master.dockerproject.org/linux/amd64/docker-1.9.0-dev
ENV DOCKER_SHA256 b4b19eb4dcbe65eb6bdced1f9f09b0f72e0e3cbf45bc7aa65ac9c645119d1086

RUN wget "${DOCKER_URL}" -O /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
