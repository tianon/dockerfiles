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
		\
# needed for "firefox --version" to succeed
		libasound2 \
		libdbus-glib-1-2 \
		libgtk-3-0 \
		libx11-xcb1 \
		libxtst6 \
		\
# needed for "glxtest" to succeed (at runtime)
		libegl1 \
		libgl1 \
		libpci3 \
	; \
	rm -rf /var/lib/apt/lists/*

ENV PATH /opt/firefox:$PATH

# https://archive.mozilla.org/pub/firefox/releases/
# https://download-installer.cdn.mozilla.net/pub/firefox/releases/
# https://www.mozilla.org/en-US/firefox/all/#product-desktop-release
ENV FIREFOX_VERSION 130.0

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		bzip2 \
		gnupg \
		wget \
	; \
	\
	wget -O firefox.tbz2.asc "https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2.asc"; \
	wget -O firefox.tbz2 "https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2" --progress=dot:giga; \
	\
	GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
# https://archive.mozilla.org/pub/firefox/releases/92.0/KEY
# https://keys.openpgp.org/search?q=release%40mozilla.com
	gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys 14F26682D0916CDD81E37B6D61B7B526D98F0353; \
	gpg --batch --verify firefox.tbz2.asc firefox.tbz2; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" firefox.tbz2.asc; \
	\
	tar -xvf firefox.tbz2 -C /opt; \
	[ -d /opt/firefox ]; \
	rm firefox.tbz2; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	firefox --version

# disable automated updates
# https://github.com/mozilla/policy-templates/blob/v3.3/README.md
RUN set -eux; \
	mkdir /opt/firefox/distribution; \
	echo '{"policies":{"AppAutoUpdate":false}}' > /opt/firefox/distribution/policies.json

CMD ["firefox"]
