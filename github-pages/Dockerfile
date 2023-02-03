#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

# https://pages.github.com/versions/
FROM ruby:2.7-alpine3.16

ENV GITHUB_PAGES_VERSION 228

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
	apk del --no-network .build-deps; \
	\
	jekyll serve --help > /dev/null

WORKDIR /blog
EXPOSE 4000
CMD ["jekyll", "serve", "--host", "0.0.0.0"]

ONBUILD COPY . /blog
