#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

# ideally, we'd use official static binary releases from http://landley.net/toybox/downloads/binaries/ but they don't include the (pending) "sh" implementation so they're not quite enough for a full system yet
# https://github.com/landley/toybox/commits/master/toys/pending/sh.c

FROM alpine:3.20 AS build

RUN set -eux; \
	apk add --no-cache \
		bash \
		gcc \
		linux-headers \
		make \
		musl-dev \
# https://github.com/landley/toybox/issues/493#issuecomment-2050906703 (why the GNU tools *and* why Alpine / musl)
		findutils cpio \
	;

WORKDIR /toybox

# https://landley.net/toybox/downloads/?C=M;O=D
# https://github.com/landley/toybox/releases
ENV TOYBOX_VERSION 0.8.11

RUN set -eux; \
	wget -O toybox.tgz "https://landley.net/toybox/downloads/toybox-$TOYBOX_VERSION.tar.gz"; \
	tar -xf toybox.tgz --strip-components=1; \
	rm toybox.tgz

# pre-build toybox for the build to use 👀
RUN sh -eux scripts/prereq/build.sh

RUN make root

# smoke-test/verify the result
RUN chroot root/host/fs sh -c 'PS4="++ " && set -ux && echo hi from toybox'
# TODO add "set -e" and swap to semi-colons when toybox sh supports it :D
# TODO adjusting PS4 because *something* about https://github.com/landley/toybox/blob/122bbe602f50b7fe747751370035f6fd55e674d0/toys/pending/sh.c#L3684-L3701 seems to think our "call depth" is zero instead of one

FROM scratch
COPY --from=build /toybox/root/host/fs/ /
CMD ["sh"]
