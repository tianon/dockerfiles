FROM ruby:2

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN gem install passenger

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY Gemfile* *.gemspec /usr/src/app/
ONBUILD RUN bundle install

ONBUILD COPY . /usr/src/app

EXPOSE 3000
CMD ["passenger", "start"]
