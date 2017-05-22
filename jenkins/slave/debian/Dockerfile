FROM buildpack-deps:stretch-scm

RUN apt-get update && apt-get install -y --no-install-recommends \
		openjdk-8-jre-headless \
		openssh-server \
		\
		aufs-tools \
		btrfs-tools \
		e2fsprogs \
		iptables \
		xz-utils \
		\
		bsdmainutils \
	&& rm -rf /var/lib/apt/lists/* \
	&& sed -ri 's/^#?PermitRootLogin[[:space:]].*$/PermitRootLogin yes/g' /etc/ssh/sshd_config

ENV DIND_COMMIT 3b5fac462d21ca164b3778647420016315289034
RUN wget "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind" -O /usr/local/bin/dind \
	&& chmod +x /usr/local/bin/dind

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.9.1
ENV DOCKER_SHA256 52286a92999f003e1129422e78be3e1049f963be1888afc3c9a99d5a9af04666

RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker \
	&& /usr/local/bin/docker -v

ENV ENTRYPOINT_COMMIT e33e7226872e53dfa88bee09f153704a66fc103d
RUN curl -fSL "https://github.com/docker-library/docker/raw/${ENTRYPOINT_COMMIT}/${DOCKER_VERSION%.*}/dind/dockerd-entrypoint.sh" -o /usr/local/bin/dockerd-entrypoint.sh \
	&& chmod +x /usr/local/bin/dockerd-entrypoint.sh \
	&& sed -i 's!/bin/sh!/bin/bash!g' /usr/local/bin/dockerd-entrypoint.sh

RUN ssh-keygen -A
RUN echo 'root:docker' | chpasswd

# let's make /root a volume so ~/.ssh/authorized_keys is easier to save
VOLUME /root

EXPOSE 22
COPY i-am-a-terrible-person.sh /
ENTRYPOINT ["/i-am-a-terrible-person.sh"]
CMD []
