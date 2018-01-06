FROM debian:stretch-slim

# /var/lib/dpkg/info/plexmediaserver.postinst: 39: /var/lib/dpkg/info/plexmediaserver.postinst: start: not found
RUN ln -s /bin/true /usr/local/bin/start

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	&& rm -rf /var/lib/apt/lists/*

# https://www.plex.tv/downloads/#getdownload
# https://plex.tv/api/downloads/1.json
ENV PLEX_VERSION 1.10.1.4602-f54242b6b
ENV PLEX_URL https://downloads.plex.tv/plex-media-server/1.10.1.4602-f54242b6b/plexmediaserver_1.10.1.4602-f54242b6b_amd64.deb
ENV PLEX_SHA1 b3f40fe8684d708da9c090750a5e3be6f02d8ff8

RUN set -eux; \
	wget -O /tmp/plex.deb "$PLEX_URL"; \
	echo "$PLEX_SHA1 */tmp/plex.deb" | sha1sum -c -; \
	apt-get update; \
	apt-get install /tmp/plex.deb; \
	rm -rf /var/lib/apt/lists/*; \
	rm /tmp/plex.deb

ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /var/lib/plexmediaserver/Library/Application Support
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
ENV PLEX_MEDIA_SERVER_INFO_DEVICE docker
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 6
ENV PLEX_MEDIA_SERVER_TMPDIR /tmp
ENV LD_LIBRARY_PATH /usr/lib/plexmediaserver
ENV LANG C.UTF-8

RUN mkdir -p "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR" && chmod -R a+rwX "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR"
VOLUME $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR

COPY docker-entrypoint.sh /

EXPOSE 32400
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/lib/plexmediaserver/Plex Media Server"]
