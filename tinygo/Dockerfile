#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM golang:1.24-bookworm

# the .deb (as of 0.6.0) installs to /usr/local/tinygo but doesn't add "tinygo" to PATH
ENV PATH /usr/local/tinygo/bin:$PATH
# https://tinygo.org/getting-started/linux/

# https://github.com/tinygo-org/tinygo/releases
ENV TINYGO_VERSION 0.38.0

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	; \
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	\
	wget --progress=dot:giga -O tinygo.deb "https://github.com/tinygo-org/tinygo/releases/download/v$TINYGO_VERSION/tinygo_${TINYGO_VERSION}_amd64.deb"; \
	apt-get install -y --no-install-recommends ./tinygo.deb; \
	rm -rf tinygo.deb /var/lib/apt/lists/*; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	tinygo version
