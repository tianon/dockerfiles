#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

# https://pages.github.com/versions/
FROM ruby:2.7-alpine3.16
# https://www.ruby-lang.org/en/news/2023/03/30/ruby-2-7-8-released/
# https://github.com/github/pages-gem/issues/752#issuecomment-1563750824 🙈

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
# The last version of nokogiri (>= 1.13.6, < 2.0) to support your Ruby & RubyGems was 1.15.5. Try installing it with `gem install nokogiri -v 1.15.5` and then running the current command again 🙃
	gem install nokogiri -v '~> 1.15.4'; \
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
