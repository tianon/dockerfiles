FROM alpine:3.4

# gpg: key 64EA74AB: public key "Chet Ramey <chet@cwru.edu>" imported
ENV _BASH_GPG_KEY 7C0135FB088AAF6C66C650B9BB5869F064EA74AB

# https://ftp.gnu.org/gnu/bash/?C=M;O=D
ENV _BASH_VERSION 4.1
ENV _BASH_PATCH_LEVEL 0
# https://ftp.gnu.org/gnu/bash/bash-4.1-patches/?C=M;O=D
ENV _BASH_LATEST_PATCH 17
# prefixed with "_" since "$BASH..." have meaning in Bash parlance

RUN set -ex; \
	\
	apk add --no-cache --virtual .build-deps \
		bison \
		ca-certificates \
		gcc \
		gnupg \
		libc-dev \
		make \
		ncurses-dev \
		openssl \
		patch \
		tar \
	; \
	\
	version="$_BASH_VERSION"; \
	if [ "$_BASH_PATCH_LEVEL" -gt 0 ]; then \
		version="$version.$_BASH_PATCH_LEVEL"; \
	fi; \
	wget -O bash.tar.gz "https://ftp.gnu.org/gnu/bash/bash-$version.tar.gz"; \
	wget -O bash.tar.gz.sig "https://ftp.gnu.org/gnu/bash/bash-$version.tar.gz.sig"; \
	\
	if [ "$_BASH_LATEST_PATCH" -gt "$_BASH_PATCH_LEVEL" ]; then \
		mkdir -p bash-patches; \
		first="$(printf '%03d' "$(( _BASH_PATCH_LEVEL + 1 ))")"; \
		last="$(printf '%03d' "$_BASH_LATEST_PATCH")"; \
		for patch in $(seq -w "$first" "$last"); do \
			url="https://ftp.gnu.org/gnu/bash/bash-$_BASH_VERSION-patches/bash${_BASH_VERSION//./}-$patch"; \
			wget -O "bash-patches/$patch" "$url"; \
			wget -O "bash-patches/$patch.sig" "$url.sig"; \
		done; \
	fi; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$_BASH_GPG_KEY"; \
	gpg --batch --verify bash.tar.gz.sig bash.tar.gz; \
	rm bash.tar.gz.sig; \
	if [ -d bash-patches ]; then \
		for sig in bash-patches/*.sig; do \
			p="${sig%.sig}"; \
			gpg --batch --verify "$sig" "$p"; \
			rm "$sig"; \
		done; \
	fi; \
	rm -r "$GNUPGHOME"; \
	\
	mkdir -p /usr/src/bash; \
	tar \
		--extract \
		--file=bash.tar.gz \
		--strip-components=1 \
		--directory=/usr/src/bash \
	; \
	rm bash.tar.gz; \
	\
	if [ -d bash-patches ]; then \
		for p in bash-patches/*; do \
			patch \
				--directory=/usr/src/bash \
				--input="$(readlink -f "$p")" \
				--strip=0 \
			; \
			rm "$p"; \
		done; \
		rmdir bash-patches; \
	fi; \
	\
	cd /usr/src/bash; \
	./configure \
		--enable-readline \
		--with-curses \
		--without-bash-malloc \
	|| { \
		cat >&2 config.log; \
		false; \
	}; \
	make -j "$(getconf _NPROCESSORS_ONLN)"; \
	make install; \
	cd /; \
	rm -r /usr/src/bash; \
	\
# delete a few installed bits for smaller image size
	rm -r \
		/usr/local/share/info \
		/usr/local/share/locale \
		/usr/local/share/man \
	; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --recursive /usr/local \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)"; \
	apk add --no-cache --virtual .bash-rundeps $runDeps; \
	apk del .build-deps; \
	\
	[ "$(which bash)" = '/usr/local/bin/bash' ]; \
	bash --version; \
	[ "$(bash -c 'echo "${BASH_VERSION%%[^0-9.]*}"')" = "$_BASH_VERSION.$_BASH_LATEST_PATCH" ];

CMD ["bash"]
