# ideally, we'd use official static binary releases from http://landley.net/toybox/downloads/binaries/ but they don't include the (pending) "sh" implementation so they're not quite enough for a full system yet

FROM alpine:3.12 AS build

RUN set -eux; \
	apk add --no-cache \
		bash \
		gcc \
		linux-headers \
		make \
		musl-dev \
	;

WORKDIR /toybox

# https://landley.net/toybox/downloads/?C=M;O=D
# https://github.com/landley/toybox/releases
ENV TOYBOX_VERSION 0.8.3

RUN set -eux; \
	wget -O toybox.tgz "https://landley.net/toybox/downloads/toybox-$TOYBOX_VERSION.tar.gz"; \
	tar -xf toybox.tgz --strip-components=1; \
	rm toybox.tgz

# TODO set "TARGET" appropriately based on "apk --print-arch" to avoid "uname -m" detection
RUN make root BUILTIN=1
# (we set "BUILTIN=1" to avoid cpio / initramfs creation)

FROM scratch
COPY --from=build /toybox/root/host/fs/ /
CMD ["sh"]
