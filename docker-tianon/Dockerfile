FROM debian:stretch-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
	; \
	rm -rf /var/lib/apt/lists/*

# set up subuid/subgid so that "--userns-remap=default" works out-of-the-box
RUN set -eux; \
	addgroup --system dockremap; \
	adduser --system --ingroup dockremap dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

RUN echo 'deb [ allow-insecure=yes trusted=yes ] https://doi-janky.infosiftr.net/job/tianon/job/docker-deb/job/repo/lastSuccessfulBuild/artifact stretch main' > /etc/apt/sources.list.d/docker-tianon.list

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		docker-tianon \
		\
		aufs-tools \
		iproute2 \
		pigz \
		psmisc \
		xz-utils \
	; \
	rm -rf /var/lib/apt/lists/*

COPY modprobe dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
