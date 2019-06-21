FROM debian:stretch-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
	; \
	rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

# the .deb file linked at https://slack.com/downloads/instructions/debian includes "/etc/cron.daily/slack" which sets up an APT repo entry as in the following installation

# pub   rsa4096 2016-02-18 [SCEA]
#       DB08 5A08 CA13 B8AC B917  E0F6 D938 EC0D 0386 51BD
# uid           [ unknown] https://packagecloud.io/slacktechnologies/slack (https://packagecloud.io/docs#gpg_signing) <support@packagecloud.io>
# sub   rsa4096 2016-02-18 [SEA]
ENV SLACK_GPG_KEY DB085A08CA13B8ACB917E0F6D938EC0D038651BD

RUN set -eux; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		gnupg dirmngr \
	; \
	rm -rf /var/lib/apt/lists; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$SLACK_GPG_KEY"; \
	gpg --batch --export --armor "$SLACK_GPG_KEY" > /etc/apt/trusted.gpg.d/slack.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-key list; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	echo 'deb https://packagecloud.io/slacktechnologies/slack/debian jessie main' > /etc/apt/sources.list.d/slack.list

ENV SLACK_VERSION 3.4.2

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		slack-desktop="$SLACK_VERSION" \
# 3.0.2: slack: error while loading shared libraries: libX11-xcb.so.1: cannot open shared object file: No such file or directory
		libx11-xcb1 \
# 3.0.2: slack: error while loading shared libraries: libasound.so.2: cannot open shared object file: No such file or directory
		libasound2 \
# 3.3.3: slack: error while loading shared libraries: libgtk-3.so.0: cannot open shared object file: No such file or directory
		libgtk-3-0 \
	; \
	rm -rf /var/lib/apt/lists/*

CMD ["slack"]
