#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get install -y --no-install-recommends gnupg; \
	\
# https://updates.signal.org/desktop/apt/keys.asc
	key='DBA3 6B51 81D0 C816 F630  E889 D980 A174 57F6 FB06'; \
	\
	GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"; \
	mkdir -p /usr/local/share/keyrings; \
	gpg --batch --export "$key" > /usr/local/share/keyrings/signal-desktop.gpg; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	echo 'deb [ arch=amd64 signed-by=/usr/local/share/keyrings/signal-desktop.gpg ] https://updates.signal.org/desktop/apt xenial main' > /etc/apt/sources.list.d/signal-desktop.list; \
	\
	apt-get update; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/signalapp/Signal-Desktop/releases
ENV SIGNAL_DESKTOP_VERSION 7.22.2

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		signal-desktop="$SIGNAL_DESKTOP_VERSION" \
# missing Depends:
		libatk-bridge2.0-0 \
		libatk1.0-0 \
		libdrm2 \
		libgbm1 \
		libgtk-3-0 \
		libx11-xcb1 \
		libxshmfence1 \
# LaunchProcess: failed to execvp: xdg-settings
		xdg-utils \
	; \
	rm -rf /var/lib/apt/lists/*; \
	signal="$(command -v signal-desktop)"; \
	signal="$(readlink -ev "$signal")"; \
	! { ldd "$signal" | grep 'not found'; }

CMD ["signal-desktop"]
