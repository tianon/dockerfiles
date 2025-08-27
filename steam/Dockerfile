#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM ubuntu:22.04

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
# zenity is used during early startup for dialogs and progress bars
		zenity \
# wget is used for uploading crash dumps
		wget \
# needed for "dbus-launch" (not sure what that's used for)
		dbus-x11 \
# needed for "localedef" below
		locales \
	; \
	rm -rf /var/lib/apt/lists/*

# WARNING: setlocale('en_US.UTF-8') failed, using locale: 'C'. International characters may not work.
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# create a default "steam" user for running the container without root privileges
RUN set -eux; \
	adduser --disabled-password --gecos 'Steam' steam; \
	adduser steam video
ENV HOME /home/steam

# https://github.com/ValveSoftware/steam-for-linux#getting-started
# http://media.steampowered.com/client/installer/steam.deb redirects to https://repo.steampowered.com/steam/archive/stable/steam_latest.deb
# https://repo.steampowered.com/steam/archive/stable/?C=M&O=D
# https://repo.steampowered.com/steam/archive/stable/?C=N&O=D
# "steam_latest.deb" is a symlink to "steam-launcher_X.X.X.X_all.deb"
# https://repo.steampowered.com/steam/dists/stable/steam/binary-amd64/Packages (current version, current SHA256)
ENV STEAM_VERSION 1.0.0.84
ENV STEAM_SHA256 e19f23e38d40b8ffa93a203a9feea481d016f6bd67801da52127eb90374b565f
RUN set -eux; \
	if ! wget -O steam.deb 'https://repo.steampowered.com/steam/pool/steam/s/steam/steam-launcher_1.0.0.84_amd64.deb'; then \
		wget -O steam.deb 'https://repo.steampowered.com/steam/archive/stable/steam-launcher_1.0.0.84_amd64.deb'; \
	fi; \
	echo "$STEAM_SHA256 *steam.deb" | sha256sum --strict --check -; \
	apt-get update; \
	apt-get install -y ./steam.deb; \
	rm -rf steam.deb /var/lib/apt/lists/*

RUN set -eux; \
	dpkg --add-architecture i386; \
	apt-get update; \
	apt-get install -y \
# let's head off a few of the things steam will want to install immediately
		libgl1-mesa-dri:i386 \
		libgl1-mesa-glx:i386 \
		libc6:i386 \
# installing libfontconfig1 from Ubuntu stops some runtime-related fontconfig errors/warnings (https://github.com/ValveSoftware/steam-for-linux/issues/3307#issuecomment-506650268)
		libfontconfig1:i386 \
	; \
	rm -rf /var/lib/apt/lists/*

# useful when using "--env DEBUGGER=gdb" or "--env DEBUGGER=strace" to debug steam startup issues
#RUN set -eux; \
#	apt-get update; \
#	apt-get install -y --no-install-recommends \
#		gdb \
#		strace \
#	; \
#	rm -rf /var/lib/apt/lists/*

USER steam
CMD ["steam"]
