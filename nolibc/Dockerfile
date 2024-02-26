# https://lwn.net/Articles/920158/
# https://github.com/wtarreau/nolibc
# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/nolibc

FROM debian:bullseye-slim

# https://kernel.org/
ENV LINUX_VERSION 6.1.9

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

RUN set -eux; \
	wget -O linux.txz "https://cdn.kernel.org/pub/linux/kernel/v${LINUX_VERSION%%.*}.x/linux-${LINUX_VERSION}.tar.xz" --progress=dot:giga; \
	mkdir -p /tmp/linux; \
	tar --extract --file linux.txz --directory /tmp/linux --strip-components 1; \
	rm linux.txz; \
	\
# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/nolibc
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		amd64) ARCH='x86_64' ;; \
		arm64) ARCH='arm64' ;; \
		armel | armhf) ARCH='arm' ;; \
		i386) ARCH='i386' ;; \
		riscv64) ARCH='riscv64' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
	\
# "make headers" in nolibc installs to "$(OUTPUT)sysroot" so let's make a fake one we can install to
	mkdir -p /usr/local/nolibc; \
	ln -svfT /usr/local/nolibc /tmp/sysroot; \
	\
	apt-get update && apt-get install -y --no-install-recommends libc6-dev rsync; \
	make -C /tmp/linux/tools/include/nolibc \
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
	/tmp/true; \
	rm -vf /tmp/true*
