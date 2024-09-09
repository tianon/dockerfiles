#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

# https://lwn.net/Articles/920158/
# https://github.com/wtarreau/nolibc
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/include/nolibc?h=linux-rolling-stable

FROM debian:bookworm-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		gcc \
		make \
		wget \
		xz-utils \
	; \
	rm -rf /var/lib/apt/lists/*

# https://kernel.org/
# https://kernel.org/releases.json
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Makefile?h=linux-rolling-stable
# 2024-09-08
ENV LINUX_VERSION 6.10.9
ENV LINUX_SOURCE_URL https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.10.9.tar.xz
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/tools/include/nolibc?h=linux-rolling-stable
# https://github.com/gregkh/linux/commits/linux-rolling-stable/tools/include/nolibc
# https://github.com/torvalds/linux/commits/master/tools/include/nolibc

RUN set -eux; \
	wget -O 'linux.tar.xz' "$LINUX_SOURCE_URL" --progress=dot:giga; \
	mkdir -p /tmp/linux; \
	tar --extract --file 'linux.tar.xz' --directory /tmp/linux --strip-components 1; \
	rm 'linux.tar.xz'; \
	\
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/include/nolibc?h=linux-rolling-stable (arch-*.h)
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/include/nolibc/Makefile?h=linux-rolling-stable (ARCH, SUBARCH, nolibc_arch)
# https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/scripts/subarch.include?h=linux-rolling-stable (SUBARCH)
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') ARCH='x86_64' ;;  \
		'armel') ARCH='arm' ;;  \
		'armhf') ARCH='arm' ;;  \
		'arm64') ARCH='arm64' ;;  \
		'i386') ARCH='i386' ;;  \
		'mips64el') ARCH='mips' ;;  \
		'ppc64el') ARCH='powerpc' ;;  \
		'riscv64') ARCH='riscv' ;;  \
		's390x') ARCH='s390' ;;  \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
	\
# "make headers" in nolibc installs to "$(OUTPUT)sysroot" so let's make a fake one we can install to
	mkdir -p /usr/local/nolibc; \
	ln -svfT /usr/local/nolibc /tmp/sysroot; \
	\
	apt-get update && apt-get install -y --no-install-recommends libc6-dev rsync; \
	nproc="$(nproc)"; \
	make -C /tmp/linux/tools/include/nolibc -j "$nproc" \
		help \
		headers_standalone \
		ARCH="$ARCH" \
		OUTPUT='/tmp/' \
		V=1 \
	; \
	apt-get purge -y --auto-remove libc6-dev rsync && rm -rf /var/lib/apt/lists/*; \
	\
	rm -rf /tmp/linux /tmp/sysroot; \
	\
	[ -s /usr/local/nolibc/include/arch.h ]

RUN set -eux; \
	rmdir /usr/local/include; \
	ln -svfT /usr/local/nolibc/include /usr/local/include

# see "nolibc.h" for where this set originates
ENV CFLAGS -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib -static -include nolibc.h -lgcc

RUN set -exu; \
	echo 'int main() { return 0; }' > /tmp/true.c; \
	gcc $CFLAGS -o /tmp/true /tmp/true.c; \
	ls -l /tmp/true; ls -lh /tmp/true; \
	chroot /tmp /true; \
	rm -vf /tmp/true*
