FROM debian:sid

RUN apt-get update && apt-get install -yq curl

#RUN curl -sLS https://get.docker.io | sh

# let's grab the lastest "master" version of the install.sh script >:)
RUN curl -sLS https://raw.github.com/dotcloud/docker/master/hack/install.sh | sh

RUN curl -sLS https://raw.github.com/dotcloud/docker/master/hack/dind -o /dind && chmod +x /dind

ENTRYPOINT ["/dind"]
