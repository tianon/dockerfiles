FROM tianon/wine

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates wget \
		gnupg dirmngr \
	; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/Winetricks/winetricks/releases
ENV WINETRICKS_VERSION 20210825
RUN set -eux; \
	wget -O /usr/local/bin/winetricks "https://github.com/Winetricks/winetricks/raw/$WINETRICKS_VERSION/src/winetricks"; \
	chmod +x /usr/local/bin/winetricks; \
	winetricks --version

# https://github.com/lutris/lutris/releases
ENV LUTRIS_VERSION 0.5.8.4

RUN set -eux; \
	wget -O lutris.deb "https://github.com/lutris/lutris/releases/download/v${LUTRIS_VERSION}/lutris_${LUTRIS_VERSION}_all.deb"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		./lutris.deb \
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
