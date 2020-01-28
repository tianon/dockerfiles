FROM debian:buster-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		iproute2 \
		kmod \
	; \
	rm -rf /var/lib/apt/lists/*

RUN echo 'deb [ allow-insecure=yes trusted=yes ] https://doi-janky.infosiftr.net/job/tianon/job/docker-deb/job/repo/lastSuccessfulBuild/artifact buster main' > /etc/apt/sources.list.d/docker-tianon.list

# https://doi-janky.infosiftr.net/job/tianon/job/docker-deb/job/repo/lastSuccessfulBuild/artifact/pool/buster/main/amd64/
ENV DOCKER_VERSION 18.09.7-0~tianon1~buster0

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends "docker-tianon=$DOCKER_VERSION"; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/docker-library/docker/pull/166
#   dockerd-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-generating TLS certificates
#   docker-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-setting DOCKER_TLS_VERIFY and DOCKER_CERT_PATH
# (For this to work, at least the "client" subdirectory of this path needs to be shared between the client and server containers via a volume, "docker cp", or other means of data sharing.)
ENV DOCKER_TLS_CERTDIR=
# also, ensure the directory pre-exists and has wide enough permissions for "dockerd-entrypoint.sh" to create subdirectories, even when run in "rootless" mode
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client
# (doing both /certs and /certs/client so that if Docker does a "copy-up" into a volume defined on /certs/client, it will "do the right thing" by default in a way that still works for rootless users)

COPY modprobe.sh /usr/local/bin/modprobe
COPY docker-entrypoint.sh /usr/local/bin/

# dind

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		aufs-tools \
		iproute2 \
		pigz \
		procps \
		psmisc \
		xz-utils \
	; \
	rm -rf /var/lib/apt/lists/*

# set up subuid/subgid so that "--userns-remap=default" works out-of-the-box
RUN set -eux; \
	addgroup --system dockremap; \
	adduser --system --ingroup dockremap dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
