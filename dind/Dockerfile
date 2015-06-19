FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends aufs-tools btrfs-tools ca-certificates curl e2fsprogs iptables procps xz-utils && rm -rf /var/lib/apt/lists/*

RUN curl -fSL https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/bin/docker \
	&& chmod +x /usr/bin/docker \
	&& docker -v

RUN curl -fSL https://raw.githubusercontent.com/docker/docker/master/hack/dind -o /dind \
	&& chmod +x /dind

VOLUME /var/lib/docker
ENTRYPOINT ["/dind"]
CMD ["bash"]
