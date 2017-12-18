FROM debian:stretch-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		ovmf \
#		qemu-system \
#		qemu-utils \
	&& rm -rf /var/lib/apt/lists/*

COPY *.patch /qemu-patches/

# https://www.qemu.org/download/#source
ENV QEMU_VERSION 2.11.0

RUN set -eux; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
		xz-utils \
		\
		patch \
		\
		gcc \
		libc-dev \
		libglib2.0-dev \
		libpixman-1-dev \
		make \
		pkg-config \
		python \
		zlib1g-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	wget -O qemu.tar.xz "https://download.qemu.org/qemu-2.11.0.tar.xz"; \
# TODO verify signature
	mkdir /usr/src/qemu; \
	tar -xvf qemu.tar.xz -C /usr/src/qemu --strip-components=1; \
	rm qemu.tar.xz; \
	\
	cd /usr/src/qemu; \
	\
	for p in /qemu-patches/*.patch; do \
		patch --strip 1 --input "$p"; \
	done; \
	rm -rf /qemu-patches; \
	\
	./configure --help; \
	./configure; \
	make -j "$(nproc)"; \
	make install; \
	\
	cd /; \
	rm -rf /usr/src/qemu; \
	\
	libs="$( \
		find /usr/local -type f -executable -exec ldd '{}' ';' \
			| awk '/=>/ { print $(NF-1) }' \
			| sort -u \
			| xargs dpkg-query --search \
			| cut -d: -f1 \
			| sort -u \
	)"; \
	savedAptMark="$savedAptMark $libs"; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	apt-get purge -y --auto-remove

STOPSIGNAL SIGHUP

EXPOSE 22
EXPOSE 5900

COPY start-qemu /usr/local/bin/
CMD ["start-qemu"]
