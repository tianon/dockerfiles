# run with "--cap-add SYS_ADMIN" so that sbuild can "mount" in the chroots it creates

FROM debian:buster-slim

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		sbuild schroot \
		\
		debootstrap debian-archive-keyring ubuntu-archive-keyring \
		wget ca-certificates \
		\
		apt-utils \
		devscripts libwww-perl file \
		fakeroot \
		rsync sudo unzip \
	; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/tianon/debian-bin
# useful debian-related (esp. sbuild) scripts
RUN set -ex; \
	wget -O /tmp/debian-bin.tgz 'https://github.com/tianon/debian-bin/archive/91a5cd2a0a57fd72974bcf75e5def3600d2a68ea.tar.gz'; \
	mkdir /tianon-debian-bin; \
	tar -xvf /tmp/debian-bin.tgz -C /tianon-debian-bin --strip-components=1; \
	rm /tmp/debian-bin.tgz
ENV PATH $PATH:/tianon-debian-bin/generic

# usage: download-debuerreotype-tarball.sh suite [arch]
#    ie: download-debuerreotype-tarball.sh stretch
#        download-debuerreotype-tarball.sh sid i386
COPY download-debuerreotype-tarball.sh /tarballs/
RUN ln -s /tarballs/download-debuerreotype-tarball.sh /usr/local/bin/

WORKDIR /tmp
