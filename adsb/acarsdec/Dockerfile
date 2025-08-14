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
ENV LIBACARS_VERSION 2.2.0

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

# https://github.com/TLeconte/acarsdec/releases
ENV ACARSDEC_VERSION 3.7

RUN set -eux; \
	wget -O src.tgz "https://github.com/TLeconte/acarsdec/archive/refs/tags/acarsdec-$ACARSDEC_VERSION.tar.gz"; \
	tar -xvf src.tgz --strip-components=1; \
	rm src.tgz

# https://github.com/TLeconte/acarsdec#compilation

WORKDIR build

RUN cmake .. -Drtl=ON

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
	ret=0 && acarsdec --version || ret="$?"; \
	test "$ret" = 1 # https://github.com/TLeconte/acarsserv/blob/a191e1f3eea3e476500333740a03c20b6933b3fd/acarsserv.c#L273

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["acarsdec"]
