#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM ubuntu:22.04

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates wget \
		gnupg \
	; \
	rm -rf /var/lib/apt/lists/*

# CONSOLE ERROR RangeError: invalid language tag: C
RUN set -eux; \
	if [ -f /etc/dpkg/dpkg.cfg.d/docker ]; then \
# if this file exists, we're likely in "debian:xxx-slim", and locales are thus being excluded so we need to remove that exclusion (since we need locales)
		grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker; \
		sed -ri '/\/usr\/share\/locale/d' /etc/dpkg/dpkg.cfg.d/docker; \
		! grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker; \
	fi; \
	apt-get update; \
	apt-get install -y --no-install-recommends locales; \
	rm -rf /var/lib/apt/lists/*; \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8

# https://github.com/lutris/lutris/releases
ENV LUTRIS_VERSION 0.5.18

RUN set -eux; \
# turn "0.5.10-beta1" into "0.5.10_beta1" for the deb filename
	debVer="$(echo "$LUTRIS_VERSION" | tr '-' '_')"; \
	wget -O lutris.deb "https://github.com/lutris/lutris/releases/download/v${LUTRIS_VERSION}/lutris_${debVer}_all.deb"; \
	dpkg --add-architecture i386; \
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
# Couldn't find a terminal emulator.
		xterm \
# dark theme support
		gnome-themes-extra \
	; \
	rm -rf /var/lib/apt/lists/*

ENV PATH /usr/games:$PATH

CMD ["lutris"]
