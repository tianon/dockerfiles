FROM ruby:2.6-alpine3.12

RUN apk add --no-cache \
		git

ENV TRAVIS_CLI_VERSION 1.9.1

RUN set -ex; \
	apk add --no-cache --virtual .build-deps \
		gcc \
		libc-dev \
		make \
	; \
	gem install travis -v "$TRAVIS_CLI_VERSION"; \
	apk del .build-deps

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["travis"]
