# run with "--cap-add SYS_ADMIN" so that sbuild can "mount" in the chroots it creates

FROM debian:stretch-slim

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		sbuild schroot \
		\
		debootstrap \
		wget ca-certificates \
	; \
	rm -rf /var/lib/apt/lists/*

# usage: download-debuerreotype-tarball.sh suite [arch]
#    ie: download-debuerreotype-tarball.sh stretch
#        download-debuerreotype-tarball.sh sid i386
COPY download-debuerreotype-tarball.sh /tarballs/
RUN ln -s /tarballs/download-debuerreotype-tarball.sh /usr/local/bin/

WORKDIR /tmp
