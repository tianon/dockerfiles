#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

RUN set -eux; \
	apt-get install --update -y --no-install-recommends \
		ca-certificates \
	; \
	apt-get dist-clean

RUN set -eux; \
	groupadd --gid 1000 user; \
	useradd --uid 1000 --gid user --create-home user

# https://github.com/rakshasa/rtorrent/releases
ENV RTORRENT_VERSION 0.16.5
ENV LIBTORRENT_SHA256 9c604b851381bfe68e122995b6a2e7e3f16d2438b715e41d967c5b5e503062a9
ENV RTORRENT_SHA256 62ebd7662d02bdff005bc29a4b3385238e703bbe2b0c845ea7ae1ffaf9cb66c8

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get install --update -y --no-install-recommends \
		wget \
	; \
	\
	wget -O libtorrent.tar.gz "https://github.com/rakshasa/rtorrent/releases/download/v$RTORRENT_VERSION/libtorrent-$RTORRENT_VERSION.tar.gz"; \
	wget -O rtorrent.tar.gz "https://github.com/rakshasa/rtorrent/releases/download/v$RTORRENT_VERSION/rtorrent-$RTORRENT_VERSION.tar.gz"; \
	{ \
		echo "$LIBTORRENT_SHA256 *libtorrent.tar.gz"; \
		echo "$RTORRENT_SHA256 *rtorrent.tar.gz"; \
	} | sha256sum --strict --check -; \
	\
	mkdir /tmp/libtorrent; \
	tar --extract --file libtorrent.tar.gz --directory /tmp/libtorrent --strip-components=1 "libtorrent-$RTORRENT_VERSION"; \
	mkdir /tmp/rtorrent; \
	tar --extract --file rtorrent.tar.gz --directory /tmp/rtorrent --strip-components=1 "rtorrent-$RTORRENT_VERSION"; \
	\
	rm -f libtorrent.tar.gz rtorrent.tar.gz; \
	\
	apt-get install -y --no-install-recommends \
		dpkg-dev \
		g++ \
		gcc \
		libc6-dev \
		libcurl4-openssl-dev \
		libncursesw5-dev \
		libssl-dev \
		make \
		pkgconf \
		zlib1g-dev \
	; \
	\
	debflags="$(dpkg-buildflags --export=sh)"; \
	eval "$debflags"; \
	nproc="$(nproc)"; \
	\
	cd /tmp/libtorrent; \
	./configure; \
	make -j "$nproc"; \
	make install-strip; \
	cd /; rm -rf /tmp/libtorrent; \
	\
	cd /tmp/rtorrent; \
	./configure; \
	make -j "$nproc"; \
	make install-strip; \
	cd /; rm -rf /tmp/rtorrent; \
	\
	ldconfig; \
	rtorrent -h; \
	\
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	find /usr/local -type f -executable -exec ldd '{}' ';' \
		| awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); printf "*%s\n", so }' \
		| sort -u \
		| xargs -rt dpkg-query --search \
# https://manpages.debian.org/trixie/dpkg/dpkg-query.1.en.html#S (we ignore diversions and it'll be really unusual for more than one package to provide any given .so file)
		| awk 'sub(":$", "", $1) { print $1 }' \
		| sort -u \
		| xargs -r apt-mark manual \
	; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	apt-get dist-clean; \
	\
	rtorrent -h

RUN set -eux; \
	mkdir /torrents /torrents/session; \
	touch /torrents/.rtorrent.rc; \
	chown -R user:user /torrents
VOLUME /torrents

COPY --chown=user:user rtorrent.rc /home/user/.rtorrent.rc

USER user
CMD ["rtorrent"]
