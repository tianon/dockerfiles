# see https://repo.skype.com

FROM debian:jessie

RUN useradd --create-home user

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

# https://repo.skype.com/data/SKYPE-GPG-KEY
ENV SKYPE_REPO_GPG \
# pub   2048R/DF7587C3 2016-06-22 [expires: 2021-06-21]
#       Key fingerprint = D404 0146 BE39 7250 9FD5  7FC7 1F30 45A5 DF75 87C3
# uid                  Skype Linux Client Repository <se-um@microsoft.com>
# sub   2048R/A4EBB320 2016-06-22 [expires: 2021-06-21]
	D4040146BE3972509FD57FC71F3045A5DF7587C3

RUN set -ex; \
	export GNUPGHOME="$(mktemp -d)"; \
	for key in $SKYPE_REPO_GPG; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done; \
	gpg --export $GPG_KEYS > /etc/apt/trusted.gpg.d/skype.gpg; \
	rm -r "$GNUPGHOME"; \
	apt-key list

RUN echo 'deb [arch=amd64] https://repo.skype.com/deb stable main' > /etc/apt/sources.list.d/skype-stable.list

ENV SKYPE_VERSION 5.1.0.1

RUN apt-get update \
	&& apt-get install -y \
		skypeforlinux="$SKYPE_VERSION" \
	&& rm -rf /var/lib/apt/lists/*

COPY skypefordocker /usr/local/bin/

USER user
VOLUME /home/user
CMD ["skypefordocker"]
