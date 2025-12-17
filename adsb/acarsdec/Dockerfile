#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim AS base

FROM base AS build

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		cmake \
		gcc \
		libc6-dev \
		libcjson-dev \
		librtlsdr-dev \
		make \
		pkg-config \
		wget \
		\
# libacars
		libjansson-dev \
		libxml2-dev \
		zlib1g-dev \
	; \
	apt-get dist-clean

WORKDIR /libacars

# https://github.com/szpajder/libacars/releases
ENV LIBACARS_VERSION 2.2.1

RUN set -eux; \
	wget -O src.tgz "https://github.com/szpajder/libacars/archive/refs/tags/v${LIBACARS_VERSION}.tar.gz"; \
	tar -xvf src.tgz --strip-components=1; \
	rm src.tgz

WORKDIR build

RUN cmake ..

WORKDIR libacars

RUN set -eux; \
	nproc="$(nproc)"; \
	make -j "$(nproc)"; \
	make install; \
	ldconfig

WORKDIR /acarsdec

# https://github.com/f00b4r0/acarsdec/releases
ENV ACARSDEC_VERSION 4.4.1

RUN set -eux; \
	wget -O src.tgz "https://github.com/f00b4r0/acarsdec/archive/refs/tags/v$ACARSDEC_VERSION.tar.gz"; \
	tar -xvf src.tgz --strip-components=1; \
	rm src.tgz

# https://github.com/f00b4r0/acarsdec#compilation

# make sure "-DVERSION" gets used instead of "git describe" (which won't work)
RUN set -eux; \
	grep 'OUTPUT_VARIABLE VERSION' CMakeLists.txt; \
	sed -ri -e '/OUTPUT_VARIABLE VERSION/d' CMakeLists.txt

WORKDIR build

RUN cmake .. -DVERSION="$ACARSDEC_VERSION tianon" -DRTLSDR=ON -DLIBACARS=ON -DCJSON=ON

# verify that "VERSION" got embedded correctly
RUN grep -F "VERSION=\"\\\"$ACARSDEC_VERSION tianon\\\"\"" CMakeFiles/acarsdec.dir/flags.make

RUN set -eux; \
	nproc="$(nproc)"; \
	make -j "$nproc"

RUN set -eux; \
	mkdir /out /out/lib; \
	cp -al acarsdec /out/; \
	find /out -type f -executable -exec ldd '{}' ';' \
		| awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { system("cp -v " so " /out/lib/ >&2"); next }; gsub("^/(usr/)?", "", so); printf "*%s\n", so }' \
		| sort -u \
		| xargs -r dpkg-query --search \
		| cut -d: -f1 \
		| sort -u \
		| tee /out/apt-deps.txt

FROM base

ENV PATH $PATH:/opt/acarsdec
ENV LD_LIBRARY_PATH /opt/acarsdec/lib
WORKDIR /opt/acarsdec
COPY --from=build /out/apt-deps.txt ./
RUN set -eux; \
	apt-get update; \
	xargs -rt < ./apt-deps.txt \
		apt-get install -y --no-install-recommends \
	; \
	apt-get dist-clean
COPY --from=build /out/ ./
RUN set -eux; \
	{ acarsdec --help || :; } 2>&1 | grep 'tianon'; \
	ret=0 && acarsdec --help || ret="$?"; \
	test "$ret" = 1 # https://github.com/f00b4r0/acarsdec/blob/9b2d04e101340b397d8fd4862ff82a35f3cc6de3/acarsdec.c#L189

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["acarsdec"]
