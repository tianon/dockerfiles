#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		rtl-sdr \
	; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/merbanan/rtl_433/releases
ENV RTL_433_VERSION 25.02

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		cmake \
		gcc \
		libc6-dev \
		librtlsdr-dev \
		libusb-1.0-0-dev \
		make \
		pkg-config \
		wget \
	; \
	\
	cd /tmp; \
	wget -O src.tgz "https://github.com/merbanan/rtl_433/archive/refs/tags/$RTL_433_VERSION.tar.gz"; \
	mkdir rtl_433; \
	tar -xvf src.tgz -C rtl_433 --strip-components=1; \
	rm src.tgz; \
	\
	mkdir rtl_433/build; \
	cd rtl_433/build; \
	cmake .. -DENABLE_RTLSDR=ON; \
	nproc="$(nproc)"; \
	make -j "$nproc"; \
	make install; \
	\
	cd /tmp; \
	rm -rf /tmp/rtl_433; \
	\
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*; \
	\
	rtl_433 -V

CMD ["rtl_433"]
