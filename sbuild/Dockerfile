# run with "--cap-add SYS_ADMIN" so that sbuild can "mount" in the chroots it creates

FROM debian:stretch-slim

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

# https://gist.github.com/tianon/a0080cbca558e4b907fe
# (useful sbuild-related scripts)
RUN set -ex; \
	wget -O /tmp/sbuild-bins.tgz 'https://gist.github.com/tianon/a0080cbca558e4b907fe/archive/05d13124573c1f51f2ad40041444643abeab9935.tar.gz'; \
	mkdir /tianon-sbuild-bins; \
	tar -xvf /tmp/sbuild-bins.tgz -C /tianon-sbuild-bins --strip-components=1; \
	rm /tmp/sbuild-bins.tgz
ENV PATH $PATH:/tianon-sbuild-bins

# usage: download-debuerreotype-tarball.sh suite [arch]
#    ie: download-debuerreotype-tarball.sh stretch
#        download-debuerreotype-tarball.sh sid i386
COPY download-debuerreotype-tarball.sh /tarballs/
RUN ln -s /tarballs/download-debuerreotype-tarball.sh /usr/local/bin/

WORKDIR /tmp
