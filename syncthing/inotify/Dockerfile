FROM debian:jessie

RUN useradd --create-home user

RUN apt-get update && apt-get install -y ca-certificates --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV SYNCTHING_INOTIFY_VERSION 0.6.7

RUN set -x \
	&& apt-get update && apt-get install -y curl --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& tarball="syncthing-inotify-linux-amd64-v${SYNCTHING_INOTIFY_VERSION}.tar.gz" \
	&& curl -fSL "https://github.com/syncthing/syncthing-inotify/releases/download/v${SYNCTHING_INOTIFY_VERSION}/$tarball" -O \
	&& apt-get purge -y --auto-remove curl \
	&& tar -xvf "$tarball" syncthing-inotify \
	&& mv syncthing-inotify /usr/local/bin/syncthing-inotify \
	&& rm "$tarball"

USER user
CMD ["syncthing-inotify"]
