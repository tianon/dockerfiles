FROM debian:jessie

RUN apt-get update && apt-get install -y aufs-tools ca-certificates curl git iptables xz-utils

RUN curl -SL https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/bin/docker \
	&& chmod +x /usr/bin/docker

RUN curl -SL https://raw.github.com/dotcloud/docker/master/hack/dind -o /dind \
	&& chmod +x /dind

VOLUME /var/lib/docker
ENTRYPOINT ["/dind"]
