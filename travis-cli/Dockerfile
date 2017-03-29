FROM ruby:2.4-alpine

ENV TRAVIS_CLI_VERSION 1.8.8

RUN set -ex; \
	apk add --no-cache --virtual .build-deps \
		gcc \
		libc-dev \
		make \
	; \
	gem install travis -v "$TRAVIS_CLI_VERSION"; \
	apk del .build-deps

CMD ["travis"]
