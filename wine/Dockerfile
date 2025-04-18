#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# https://wiki.winehq.org/Debian

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends apt-transport-https ca-certificates; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get install -y --no-install-recommends gnupg; \
	rm -rf /var/lib/apt/lists/*; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys D43F640145369C51D786DDEA76F1A20FF987672F; \
	gpg --batch --export --armor D43F640145369C51D786DDEA76F1A20FF987672F > /etc/apt/trusted.gpg.d/winehq.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-key list | grep 'WineHQ'; \
	\
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	dpkg --add-architecture i386; \
	suite="$(awk '$1 == "Suites:" { print $2; exit }' /etc/apt/sources.list.d/debian.sources)"; \
	echo "deb https://dl.winehq.org/wine-builds/debian $suite main" > /etc/apt/sources.list.d/winehq.list

# https://dl.winehq.org/wine-builds/debian/dists/bookworm/main/binary-amd64/?C=N;O=D
# https://www.winehq.org/news/
ENV WINE_VERSION 10.0.0.0
ENV WINE_DEB_VERSION 10.0.0.0~bookworm-1

RUN set -eux; \
	{ \
		echo 'Package: src:*wine*:any'; \
		echo "Pin: version $WINE_DEB_VERSION"; \
		echo 'Pin-Priority: 1001'; \
	} > /etc/apt/preferences.d/winehq.pref; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"winehq-stable=$WINE_DEB_VERSION" \
	; \
	rm -rf /var/lib/apt/lists/*; \
	wine --version
