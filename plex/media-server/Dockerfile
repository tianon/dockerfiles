FROM debian:buster-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/plexinc/pms-docker/blob/7529befa25c89a67731129f71ee73c22a3a647d6/root/etc/services.d/plex/run
# https://support.plex.tv/articles/200273978-linux-user-and-storage-configuration/
# https://github.com/plexinc/PlexMediaServer-Ubuntu/blob/1c48f4aa97a223143ec6a7bdbbb7942a15dc70cf/debian/start_pms
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /var/lib/plexmediaserver/Library/Application Support
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
ENV PLEX_MEDIA_SERVER_INFO_DEVICE docker
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 6
ENV PLEX_MEDIA_SERVER_TMPDIR /tmp
ENV LD_LIBRARY_PATH $PLEX_MEDIA_SERVER_HOME
ENV PATH $PLEX_MEDIA_SERVER_HOME:$PATH
ENV LANG C.UTF-8

# https://www.plex.tv/downloads/#getdownload
# https://plex.tv/api/downloads/1.json
ENV PLEX_VERSION 1.21.1.3842-b0c7a97d9
ENV PLEX_URL https://downloads.plex.tv/plex-media-server-new/1.21.1.3842-b0c7a97d9/debian/plexmediaserver_1.21.1.3842-b0c7a97d9_amd64.deb
ENV PLEX_SHA1 ada274138c31ec5ba61c35ef9b0209315deca173

RUN set -eux; \
	wget -O /tmp/plex.deb "$PLEX_URL" --progress=dot:giga; \
	echo "$PLEX_SHA1 */tmp/plex.deb" | sha1sum -c -; \
# the published deb has pre/post-inst scripts that don't really apply to Docker (so we'll skip "install" entirely)
# (as of 1.18.5.2309, they have bugs around Docker detection, which is mostly for avoiding init behavior)
	dpkg-deb --vextract /tmp/plex.deb /; \
#	apt-get update; \
#	apt-get install /tmp/plex.deb; \
#	rm -rf /var/lib/apt/lists/*; \
	rm /tmp/plex.deb; \
	'Plex Media Server' --version

RUN set -eux; \
	[ ! -d "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR" ]; \
	mkdir -p "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR"; \
	chmod -R a+rwX "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR"
VOLUME $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 32400
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["Plex Media Server"]
