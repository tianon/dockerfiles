#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
# needed for "glxtest" to succeed (at runtime)
#   [GFX1-]: glxtest: libpci missing
#   [GFX1-]: glxtest: libEGL no display
		libegl1 \
		libgl1 \
		libpci3 \
# without this, we have no sound (so we cannot scream)
		libpulse0 \
	; \
	apt-get dist-clean

# https://support.mozilla.org/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions
# https://www.mozilla.org/en-US/firefox/releases/
ENV FIREFOX_VERSION 147.0.2
ENV FIREFOX_DEB_VERSION 147.0.2~build1

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		gnupg \
		wget \
	; \
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	\
	GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
	wget -O firefox.gpg 'https://packages.mozilla.org/apt/repo-signing-key.gpg'; \
	gpg --batch --import firefox.gpg; \
# https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions-recommended:~:text=35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3
	gpg --batch --export --armor --output /etc/apt/keyrings/firefox.asc 35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" firefox.gpg; \
	\
	{ \
		echo 'Types: deb'; \
		echo 'URIs: http://packages.mozilla.org/apt'; \
		echo 'Suites: mozilla'; \
		echo 'Components: main'; \
		echo 'Signed-By: /etc/apt/keyrings/firefox.asc'; \
	} > /etc/apt/sources.list.d/firefox.sources; \
	{ \
		echo 'Package: firefox* mozilla*'; \
		echo 'Pin: origin packages.mozilla.org'; \
		echo 'Pin-Priority: 1000'; \
	} > /etc/apt/preferences.d/firefox.pref; \
	apt-get update; \
	apt-get install -y --no-install-recommends "firefox=$FIREFOX_DEB_VERSION"; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
# make sure "apt-get update" still works after purging image-build-time deps
	apt-get update; \
	apt-get dist-clean; \
	\
# smoke test firefox itself
	firefox --version

# https://mozilla.github.io/policy-templates/
# see "about:policies" to verify they're loaded properly
RUN set -eux; \
	mkdir -p /etc/firefox/policies; \
# disable automated updates
# https://mozilla.github.io/policy-templates/#appautoupdate
	echo '{"policies":{"AppAutoUpdate":false}}' > /etc/firefox/policies/policies.json

CMD ["firefox"]
