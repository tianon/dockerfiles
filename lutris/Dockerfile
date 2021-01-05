FROM ubuntu:focal

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates wget \
		gnupg dirmngr \
		software-properties-common \
	; \
	rm -rf /var/lib/apt/lists/*

# install Wine
#   https://github.com/lutris/docs/blob/f2bf5ca14f280e3c58d2306581294d57650c0cc2/WineDependencies.md
#   https://wiki.winehq.org/Ubuntu
RUN set -eux; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys D43F640145369C51D786DDEA76F1A20FF987672F; \
	gpg --batch --export --armor D43F640145369C51D786DDEA76F1A20FF987672F > /etc/apt/trusted.gpg.d/winehq.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-key list | grep 'WineHQ'; \
	dpkg --add-architecture i386; \
	suite="$(awk '$1 == "deb" { print $3; exit }' /etc/apt/sources.list)"; \
	echo "deb https://dl.winehq.org/wine-builds/ubuntu $suite main" > /etc/apt/sources.list.d/winehq.list
# https://dl.winehq.org/wine-builds/ubuntu/dists/focal/main/binary-amd64/?C=N;O=D
# https://www.winehq.org/news/
ENV WINE_VERSION 5.10~focal
RUN set -eux; \
	{ \
		echo 'Package: *wine* *wine*:i386'; \
		echo "Pin: version $WINE_VERSION"; \
		echo 'Pin-Priority: 1001'; \
	} > /etc/apt/preferences.d/winehq.pref; \
# "Add SDL2 Backports PPA (for Faudio package):"
	add-apt-repository ppa:cybermax-dexter/sdl2-backport; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		winehq-staging="$WINE_VERSION" \
# "For compatibility reasons, install these additional libraries:"
		libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 \
	; \
	rm -rf /var/lib/apt/lists/*
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends wget; \
	rm -rf /var/lib/apt/lists/*
# https://github.com/Winetricks/winetricks/releases
ENV WINETRICKS_VERSION 20200412
RUN set -eux; \
	wget -O /usr/local/bin/winetricks "https://github.com/Winetricks/winetricks/raw/$WINETRICKS_VERSION/src/winetricks"; \
	chmod +x /usr/local/bin/winetricks; \
	winetricks --version

# https://launchpad.net/~lutris-team/+archive/ubuntu/lutris?field.series_filter=focal
ENV LUTRIS_VERSION 0.5.8.2
ENV LUTRIS_PPA_VERSION 0.5.8.2~ubuntu20.04.1

RUN set -eux; \
	add-apt-repository ppa:lutris-team/lutris; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		lutris="$LUTRIS_PPA_VERSION" \
# https://github.com/lutris/docs/blob/f2bf5ca14f280e3c58d2306581294d57650c0cc2/InstallingDrivers.md
		libvulkan1 libvulkan1:i386 \
		libgl1-mesa-dri:i386 \
		mesa-vulkan-drivers mesa-vulkan-drivers:i386 \
# gi.repository.GLib.Error: g-exec-error-quark: Failed to execute child process “dbus-launch” (No such file or directory) (8)
		dbus-x11 \
# /lutris-home/games/battle.net/state-cache-merge/state-cache-update.sh: line 8: zenity: command not found
		zenity \
# python3-evdev not installed, controller support not available
		python3-evdev \
# lspci is not available. List of graphics cards not available
		pciutils \
	; \
	rm -rf /var/lib/apt/lists/*

ENV PATH /usr/games:$PATH

CMD ["lutris"]
