FROM debian:buster-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
# "sh: 1: pactl: not found"
		pulseaudio-utils \
# "sh: 1: ps: not found"
		procps \
# Cannot load library /opt/zoom/platforms/libqxcb.so: (libxkbcommon-x11.so.0: cannot open shared object file: No such file or directory)
		libxkbcommon-x11-0 \
	; \
	rm -rf /var/lib/apt/lists/*

# https://zoom.us/download#client_4meeting ("Debian", "64 bit", "8.0+", "Version X.Y.ZZZ.ZZZ")
ENV ZOOM_VERSION 5.5.7011.0206
# curl -fsS --head 'https://zoom.us/client/latest/zoom_amd64.deb' | grep '^location: '

RUN set -eux; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		wget \
	; \
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	wget -O zoom.deb "https://zoom.us/client/$ZOOM_VERSION/zoom_$dpkgArch.deb" --progress=dot:giga; \
	apt-get install -y --no-install-recommends ./zoom.deb; \
	rm zoom.deb; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*; \
	\
# "zoom --version", "zoom --help", etc don't seem to do anything useful
	command -v zoom

# TODO copy/steal "browser.sh" stuff from slack

CMD ["zoom"]
