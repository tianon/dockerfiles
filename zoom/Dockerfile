#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
# used as a fake browser so clicked URLs pop up with a URL + clipboard instead of silently doing nothing
		zenity xclip \
# missing Depends:
# Cannot load xxx: (yyy.so.0: cannot open shared object file: No such file or directory)
		libgl1 \
		libqt6core5compat6 \
		libqt6network6 \
		libqt6qml6 \
		libqt6quick6 \
		libqt6quickwidgets6 \
		libqt6svg6 \
		libqt6widgets6 \
		libqt6xml6 \
	; \
	apt-get dist-clean

# https://zoom.us/download#client_4meeting ("Debian", "64 bit", "8.0+", "Version X.Y.ZZZ.ZZZ")
# https://support.zoom.us/hc/en-us/articles/205759689-Release-notes-for-Linux
ENV ZOOM_VERSION 7.0.0.1666
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
	apt-get dist-clean; \
	\
# check for missing dependencies
	LD_LIBRARY_PATH='/opt/zoom:/opt/zoom/cef' ldd /opt/zoom/zoom | grep 'not found' && exit 1 || :; \
	\
# "zoom --version", "zoom --help", etc don't seem to do anything useful
	command -v zoom

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
# TODO when "zenity" pops up, if it's a link from the Settings it comes up underneath the settings dialog (since that one is always-on-top)

CMD ["zoom"]
