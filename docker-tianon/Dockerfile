FROM debian:buster-slim

RUN set -eux; \
	echo 'deb http://deb.debian.org/debian buster-backports main' > /etc/apt/sources.list.d/backports.list; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		iproute2 \
		kmod \
# DOCKER_HOST=ssh://... -- https://github.com/docker/cli/pull/1014
		openssh-client \
# https://github.com/debuerreotype/docker-debian-artifacts/issues/97#issuecomment-658469709 (2.4.2+)
# https://github.com/seccomp/libseccomp/issues/234 (2.4.4+)
		libseccomp2/buster-backports \
	; \
	rm -rf /var/lib/apt/lists/*

RUN echo 'deb [ allow-insecure=yes trusted=yes ] https://doi-janky.infosiftr.net/job/tianon/job/docker-deb/job/repo/lastSuccessfulBuild/artifact buster main' > /etc/apt/sources.list.d/docker-tianon.list

# https://doi-janky.infosiftr.net/job/tianon/job/docker-deb/job/repo/lastSuccessfulBuild/artifact/pool/buster/main/amd64/
ENV DOCKER_VERSION 19.03.12-0~tianon1~buster0

RUN set -eux; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends "docker-tianon=$DOCKER_VERSION"; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dockerd --version; \
	docker --version

COPY modprobe.sh /usr/local/bin/modprobe
COPY docker-entrypoint.sh /usr/local/bin/

# https://github.com/docker-library/docker/pull/166
#   dockerd-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-generating TLS certificates
#   docker-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-setting DOCKER_TLS_VERIFY and DOCKER_CERT_PATH
# (For this to work, at least the "client" subdirectory of this path needs to be shared between the client and server containers via a volume, "docker cp", or other means of data sharing.)
ENV DOCKER_TLS_CERTDIR=
# also, ensure the directory pre-exists and has wide enough permissions for "dockerd-entrypoint.sh" to create subdirectories, even when run in "rootless" mode
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client
# (doing both /certs and /certs/client so that if Docker does a "copy-up" into a volume defined on /certs/client, it will "do the right thing" by default in a way that still works for rootless users)

# dind

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		iproute2 \
		iptables \
		openssl \
		procps \
		psmisc \
		xz-utils \
# pigz: https://github.com/moby/moby/pull/35697 (faster gzip implementation)
		pigz \
	; \
	rm -rf /var/lib/apt/lists/*

# set up subuid/subgid so that "--userns-remap=default" works out-of-the-box
RUN set -eux; \
	addgroup --system dockremap; \
	adduser --system --ingroup dockremap dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

# https://github.com/docker/docker/tree/master/hack/dind
#ENV DIND_COMMIT 130b0bc6032cc675d064e1cc62626cacc9c07a57

#RUN set -eux; \
#	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
#	chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
