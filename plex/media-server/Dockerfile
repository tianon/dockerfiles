FROM buildpack-deps:jessie-curl

# /var/lib/dpkg/info/plexmediaserver.postinst: 39: /var/lib/dpkg/info/plexmediaserver.postinst: start: not found
RUN ln -s /bin/true /usr/local/bin/start

# https://www.plex.tv/downloads/#getdownload
ENV PLEX_VERSION 1.4.3.3433-03e4cfa35

ENV PLEX_URL https://downloads.plex.tv/plex-media-server/${PLEX_VERSION}/plexmediaserver_${PLEX_VERSION}_amd64.deb

RUN curl -fSL "$PLEX_URL" -o /tmp/plex.deb \
	&& dpkg --unpack /tmp/plex.deb \
	&& apt-get install -f \
	&& rm /tmp/plex.deb

ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /var/lib/plexmediaserver/Library/Application Support
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
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
