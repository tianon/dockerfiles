# https://pages.github.com/versions/
FROM ruby:2.5-slim

ENV GITHUB_PAGES_VERSION 197

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		make \
		gcc \
		g++ \
		patch \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	gem install github-pages -v "$GITHUB_PAGES_VERSION"; \
	\
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	jekyll serve --help > /dev/null

WORKDIR /blog
EXPOSE 4000
CMD ["jekyll", "serve", "--host", "0.0.0.0"]

ONBUILD COPY . /blog
