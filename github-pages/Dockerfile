# https://pages.github.com/versions/
FROM ruby:2.3-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		gcc make patch \
		nodejs python-pygments \
	&& rm -rf /var/lib/apt/lists/*

RUN gem install github-pages

WORKDIR /blog
EXPOSE 4000
CMD ["jekyll", "serve", "--host", "0.0.0.0"]

ONBUILD COPY . /blog
