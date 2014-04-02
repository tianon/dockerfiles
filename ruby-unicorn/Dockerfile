FROM debian:unstable

RUN apt-get update && apt-get install -yq bundler

# set a few bundle config variables so that a local .bundle in our development directory doesn't screw up our image
ENV BUNDLE_APP_CONFIG /apps/bundle
ENV BUNDLE_PATH /apps/gems

ENV RAILS_ENV production
ENV RACK_ENV deployment

WORKDIR /apps/rails

RUN apt-get update && apt-get install -yq unicorn
CMD ["unicorn"]
EXPOSE 8080

# TODO find a clean way to do this here in such a way that gems like rmagick can install cleanly without first installing libmagickcore-dev
#ONBUILD ADD Gemfile /apps/rails/Gemfile
#ONBUILD ADD Gemfile.lock /apps/rails/Gemfile.lock
#ONBUILD RUN bundle install --deployment
#ONBUILD ADD . /apps/rails
