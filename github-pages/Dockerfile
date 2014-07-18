FROM debian:sid

RUN apt-get update && apt-get install -y \
		build-essential \
		python-pygments \
		ruby \
		ruby-dev

RUN gem install --no-rdoc --no-ri github-pages

ONBUILD ADD . /blog
ONBUILD WORKDIR /blog
ONBUILD EXPOSE 4000
ONBUILD CMD ["jekyll", "serve"]
