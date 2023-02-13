#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

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
ENV PLEX_VERSION 1.31.0.6654-02189b09f

RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://downloads.plex.tv/plex-media-server-new/1.31.0.6654-02189b09f/debian/plexmediaserver_1.31.0.6654-02189b09f_amd64.deb'; sha1='6b7f6f6a2f8f813ae9cf8d44fcceb72845b7d25c' ;; \
		'armhf') url='https://downloads.plex.tv/plex-media-server-new/1.31.0.6654-02189b09f/debian/plexmediaserver_1.31.0.6654-02189b09f_armhf.deb'; sha1='bad55b820b629bdfbb4c043a995e5b537f12779a' ;; \
		'arm64') url='https://downloads.plex.tv/plex-media-server-new/1.31.0.6654-02189b09f/debian/plexmediaserver_1.31.0.6654-02189b09f_arm64.deb'; sha1='16a44ea5aaac3a540a11161aafdaf81c6cd051a7' ;; \
		'i386') url='https://downloads.plex.tv/plex-media-server-new/1.31.0.6654-02189b09f/debian/plexmediaserver_1.31.0.6654-02189b09f_i386.deb'; sha1='daa65f27163d9a588e33979ec24e7e5ea398e7a4' ;; \
		*) echo >&2 "error: unsupported architecture '$dpkgArch'"; exit 1 ;; \
	esac; \
	wget -O /tmp/plex.deb "$url" --progress=dot:giga; \
	echo "$sha1 */tmp/plex.deb" | sha1sum --strict --check -; \
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
