#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim AS base

FROM base AS build

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		gcc \
		libc6-dev \
		libncurses-dev \
		librtlsdr-dev \
		libzstd-dev \
		make \
		pkg-config \
		wget \
		zlib1g-dev \
	; \
	rm -rf /var/lib/apt/lists/*

WORKDIR /readsb

# https://github.com/wiedehopf/readsb
ENV READSB_COMMIT 04b69dfd0f2fe2526a15c51ff593679bba41c058
# https://github.com/wiedehopf/readsb/tags
ENV READSB_VERSION 3.14.1682

RUN set -eux; \
	wget -O src.tgz "https://github.com/wiedehopf/readsb/archive/$READSB_COMMIT.tar.gz"; \
	tar -xvf src.tgz --strip-components=1; \
	rm src.tgz

RUN set -eux; \
	nproc="$(nproc)"; \
	make -j "$nproc" \
# https://github.com/wiedehopf/readsb/blob/HEAD/Makefile
# https://github.com/wiedehopf/readsb/blob/HEAD/Dockerfile
		READSB_VERSION="\"$READSB_VERSION tianon\"" \
		RTLSDR='yes' \
		PRINT_UUIDS=yes TRACKS_UUID=yes

RUN set -eux; \
	mkdir /out; \
	cp -al readsb viewadsb /out/; \
	find /out -type f -executable -exec ldd '{}' ';' \
		| awk '/=>/ { so = $(NF-1); if (index(so, "/usr/local/") == 1) { next }; gsub("^/(usr/)?", "", so); printf "*%s\n", so }' \
		| sort -u \
		| xargs -r dpkg-query --search \
		| cut -d: -f1 \
		| sort -u \
		> /out/apt-deps.txt

FROM base

ENV PATH $PATH:/opt/readsb
WORKDIR /opt/readsb
COPY --from=build /out/apt-deps.txt ./
RUN set -eux; \
	apt-get update; \
	xargs -rt < ./apt-deps.txt \
		apt-get install -y --no-install-recommends \
	; \
	rm -rf /var/lib/apt/lists/*
COPY --from=build /out/ ./
RUN readsb --version

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["readsb"]
