FROM debian:stretch-slim

# https://www.google.com/linuxrepositories/
ENV GPG_KEYS \
# pub   rsa4096 2016-04-12 [SC]
#       EB4C 1BFD 4F04 2F6D DDCC  EC91 7721 F63B D38B 4796
# uid           [ unknown] Google Inc. (Linux Packages Signing Authority) <linux-packages-keymaster@google.com>
# sub   rsa4096 2016-04-12 [S] [expires: 2019-04-12]
		EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796
# pub   dsa1024 2007-03-08 [SC]
#       4CCA 1EAF 950C EE4A B839  76DC A040 830F 7FAC 5991
# uid           [ unknown] Google, Inc. Linux Package Signing Key <linux-packages-keymaster@google.com>
# sub   elg2048 2007-03-08 [E]
#		4CCA1EAF950CEE4AB83976DCA040830F7FAC5991

RUN set -eux; \
	\
	aptMark="$(apt-mark showmanual)"; \
	if ! command -v gpg; then \
		apt-get update; \
		apt-get install -y --no-install-recommends gnupg; \
		if ! command -v dirmngr; then \
			apt-get install -y --no-install-recommends dirmngr; \
		fi; \
		rm -rf /var/lib/apt/lists/*; \
	fi; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	for key in $GPG_KEYS; do \
		gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done; \
	gpg --batch --export --armor $GPG_KEYS | tee /etc/apt/trusted.gpg.d/google.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$aptMark" ] || apt-mark manual $aptMark; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	echo 'deb http://dl.google.com/linux/musicmanager/deb stable main' > /etc/apt/sources.list.d/google-musicmanager.list

ENV GOOGLE_MUSICMANAGER_VERSION 1.0.467.4929-r0

RUN set -ex; \
	apt-get update; \
	apt-get install -yV google-musicmanager-beta="$GOOGLE_MUSICMANAGER_VERSION"; \
	rm -rf /var/lib/apt/lists/*
