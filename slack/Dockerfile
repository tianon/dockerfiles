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
# used as a fake browser so clicked URLs (and internal Slack behavior that wants to open a browser) pop up with a URL + clipboard instead of silently doing nothing
		zenity xclip \
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
		gnupg \
	; \
	rm -rf /var/lib/apt/lists; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$SLACK_GPG_KEY"; \
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

ENV SLACK_VERSION 4.45.64

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
# 4.4.0: Error: libxkbfile.so.1: cannot open shared object file: No such file or directory
		libxkbfile1 \
# 4.4.0: libGL error: failed to load driver: (i915_dri.so, i194, i965, swrast_dir.so, swrast)
		libgl1-mesa-dri \
	; \
	rm -rf /var/lib/apt/lists/*; \
	slack="$(command -v slack)"; \
	slack="$(readlink -ev "$slack")"; \
	! { ldd "$slack" | grep 'not found'; }

COPY browser.sh /usr/local/bin/
ENV BROWSER /usr/local/bin/browser.sh
RUN set -eux; \
	for alt in \
		gnome-www-browser \
		www-browser \
		x-www-browser \
	; do \
		update-alternatives --install "/usr/bin/$alt" "$alt" "$BROWSER" 999; \
	done

CMD ["slack"]
