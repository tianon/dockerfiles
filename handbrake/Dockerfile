#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# https://github.com/HandBrake/HandBrake/releases
ENV HANDBRAKE_VERSION 1.9.2

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		bzip2 \
		ca-certificates \
		gnupg \
		wget \
		\
		autoconf \
		automake \
		autopoint \
		binutils \
		cmake \
		desktop-file-utils \
		g++ \
		gcc \
		gettext \
		libass-dev \
		libbz2-dev \
		libc6-dev \
		libdrm-dev \
		libgtk-4-dev \
		libjansson-dev \
		liblzma-dev \
		libmp3lame-dev \
		libnuma-dev \
		libopus-dev \
		libspeex-dev \
		libtheora-dev \
		libtool-bin \
		libturbojpeg-dev \
		libva-dev \
		libvorbis-dev \
		libvpx-dev \
		libx264-dev \
		libxml2-dev \
		make \
		meson \
		nasm \
		patch \
		pkg-config \
		python3 \
		\
# https://github.com/HandBrake/HandBrake/issues/6006#issuecomment-2081484348
		git \
#		libx265-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	wget -O handbrake.tar.bz2.sig "https://github.com/HandBrake/HandBrake/releases/download/$HANDBRAKE_VERSION/HandBrake-$HANDBRAKE_VERSION-source.tar.bz2.sig"; \
	wget -O handbrake.tar.bz2 "https://github.com/HandBrake/HandBrake/releases/download/$HANDBRAKE_VERSION/HandBrake-$HANDBRAKE_VERSION-source.tar.bz2"; \
	\
# https://handbrake.fr/openpgp.php or https://github.com/HandBrake/HandBrake/wiki/OpenPGP
	GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys '1629 C061 B3DD E7EB 4AE3  4B81 021D B8B4 4E4A 8645'; \
	gpg --batch --verify handbrake.tar.bz2.sig handbrake.tar.bz2; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" handbrake.tar.bz2.sig; \
	\
	mkdir -p /tmp/handbrake; \
	tar --extract \
		--file handbrake.tar.bz2 \
		--directory /tmp/handbrake \
		--strip-components 1 \
		"HandBrake-$HANDBRAKE_VERSION" \
	; \
	rm handbrake.tar.bz2; \
	\
	cd /tmp/handbrake; \
	./configure \
# TODO --arch [MODE]         select architecture mode: x86_64
		--build build \
		--enable-fdk-aac \
		--enable-numa \
		--enable-nvenc \
		--enable-qsv \
		--enable-vce \
		--enable-x265 \
	; \
	\
	nproc="$(nproc)"; \
	make -C build -j "$nproc"; \
	make -C build install; \
	\
	cd /; \
	rm -rf /tmp/handbrake; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	find /usr/local \
		-type f \
		\( -executable -o -name '*.so' \) \
		-exec ldd '{}' ';' \
		| awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); printf "*%s\n", so }' \
		| sort -u \
		| xargs -r dpkg-query --search \
		| cut -d: -f1 \
		| sort -u \
		| xargs -r apt-mark manual \
	; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	HandBrakeCLI --version; \
	ghb --help

CMD ["ghb"]
