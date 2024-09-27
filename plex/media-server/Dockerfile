#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/plexinc/pms-docker/blob/46a0358f8e00d5ba7be9d059449b617f189d6348/root/etc/services.d/plex/run
# https://support.plex.tv/articles/200273978-linux-user-and-storage-configuration/
# https://github.com/plexinc/PlexMediaServer-Ubuntu/blob/1c48f4aa97a223143ec6a7bdbbb7942a15dc70cf/debian/start_pms
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /var/lib/plexmediaserver/Library/Application Support
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
ENV PLEX_MEDIA_SERVER_INFO_VENDOR tianon https://github.com/tianon/dockerfiles/tree/HEAD/plex
ENV PLEX_MEDIA_SERVER_INFO_DEVICE docker
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 6
ENV PLEX_MEDIA_SERVER_TMPDIR /tmp
ENV LD_LIBRARY_PATH $PLEX_MEDIA_SERVER_HOME
ENV PATH $PLEX_MEDIA_SERVER_HOME:$PATH
ENV LANG C.UTF-8

# https://www.plex.tv/downloads/#getdownload
# https://plex.tv/api/downloads/1.json
ENV PLEX_VERSION 1.41.0.8994-f2c27da23

RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'i386') url='https://downloads.plex.tv/plex-media-server-new/1.41.0.8994-f2c27da23/debian/plexmediaserver_1.41.0.8994-f2c27da23_i386.deb'; sha1='bffbc91a3b83d309ed7394c93cd99752d2f04a44' ;; \
		'amd64') url='https://downloads.plex.tv/plex-media-server-new/1.41.0.8994-f2c27da23/debian/plexmediaserver_1.41.0.8994-f2c27da23_amd64.deb'; sha1='786330e6731a9519318dd6c1d039dce6ba72618c' ;; \
		'arm64') url='https://downloads.plex.tv/plex-media-server-new/1.41.0.8994-f2c27da23/debian/plexmediaserver_1.41.0.8994-f2c27da23_arm64.deb'; sha1='e8e736c00047da39bb7d366b09d409d7a279cca0' ;; \
		'armhf') url='https://downloads.plex.tv/plex-media-server-new/1.41.0.8994-f2c27da23/debian/plexmediaserver_1.41.0.8994-f2c27da23_armhf.deb'; sha1='cf48e52ffe3448d2285f3353e2a80e86c364e995' ;; \
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
