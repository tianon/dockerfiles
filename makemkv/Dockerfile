#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

# This disc requires Java runtime (JRE), but none was found. Certain functions will fail, please install Java. See http://www.makemkv.com/bdjava/ for details.
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		default-jre-headless \
	; \
	rm -rf /var/lib/apt/lists/*

# http://www.makemkv.com/forum2/viewtopic.php?f=3&t=224
ENV MAKEMKV_VERSION 1.17.7
# http://makemkv.com/download/ (release notes)

# beta code: http://www.makemkv.com/forum2/viewtopic.php?f=5&t=1053
RUN set -ex; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		g++ \
		gcc \
		gnupg \
		libavcodec-dev \
		libexpat-dev \
		libssl-dev \
		make \
		pkg-config \
		qtbase5-dev \
		wget \
		zlib1g-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	wget -O 'sha256sums.txt.sig' "https://www.makemkv.com/download/makemkv-sha-${MAKEMKV_VERSION}.txt"; \
# TODO pre-download (in versions.sh)/verify sha256sums
# pub   dsa2048 2017-05-26 [SC]
#       2ECF 2330 5F1F C0B3 2001  6733 94E3 083A 1804 2697
# uid           [ unknown] MakeMKV (signature) <support@makemkv.com>
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys 2ECF23305F1FC0B32001673394E3083A18042697; \
	gpg --batch --decrypt --output sha256sums.txt sha256sums.txt.sig; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" sha256sums.txt.sig; \
	\
	export PREFIX='/usr/local'; \
	for ball in makemkv-oss makemkv-bin; do \
		wget -O "$ball.tgz" "https://www.makemkv.com/download/${ball}-${MAKEMKV_VERSION}.tar.gz"; \
		sha256="$(grep "  $ball-${MAKEMKV_VERSION}[.]tar[.]gz\$" sha256sums.txt)"; \
		sha256="${sha256%% *}"; \
		[ -n "$sha256" ]; \
		echo "$sha256 *$ball.tgz" | sha256sum -c -; \
		\
		mkdir -p "$ball"; \
		tar -xvf "$ball.tgz" -C "$ball" --strip-components=1; \
		rm "$ball.tgz"; \
		\
		cd "$ball"; \
		if [ -f configure ]; then \
			./configure --prefix="$PREFIX"; \
		else \
			mkdir -p tmp; \
			touch tmp/eula_accepted; \
		fi; \
		make -j "$(nproc)" PREFIX="$PREFIX"; \
		make install PREFIX="$PREFIX"; \
		\
		cd ..; \
		rm -r "$ball"; \
	done; \
	\
	rm sha256sums.txt; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	find /usr/local -type f -executable -exec ldd '{}' ';' \
		| awk '/=>/ { print $(NF-1) }' \
		| sort -u \
		| xargs -r dpkg-query --search \
		| cut -d: -f1 \
		| sort -u \
		| xargs -r apt-mark manual \
	; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

CMD ["makemkv"]
