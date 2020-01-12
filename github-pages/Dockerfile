# https://pages.github.com/versions/
FROM ruby:2.5-alpine3.11

ENV GITHUB_PAGES_VERSION 202

RUN set -eux; \
	\
	apk add --no-cache --virtual .build-deps \
		make \
		gcc \
		g++ \
		patch \
	; \
	\
	gem install github-pages -v "$GITHUB_PAGES_VERSION"; \
	\
	apk del .build-deps; \
	\
	jekyll serve --help > /dev/null

WORKDIR /blog
EXPOSE 4000
CMD ["jekyll", "serve", "--host", "0.0.0.0"]

ONBUILD COPY . /blog
