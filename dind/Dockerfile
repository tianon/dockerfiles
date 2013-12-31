FROM stackbrew/debian:sid

RUN apt-get update && apt-get install -yq curl

#RUN curl -sL https://get.docker.io | sh

# let's grab the lastest "master" version of the install.sh script >:)
RUN curl -sL https://raw.github.com/tianon/docker/master/hack/install.sh | sh
