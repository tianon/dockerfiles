FROM debian:stretch-slim

# http://www.makemkv.com/forum2/viewtopic.php?f=3&t=224
ENV MAKEMKV_VERSION 1.10.5

# beta code: http://www.makemkv.com/forum2/viewtopic.php?f=5&t=1053
RUN set -ex; \
	\
	buildDeps=' \
		ca-certificates \
		g++ \
		gcc \
		libavcodec-dev \
		libexpat-dev \
		libqt4-dev \
		libssl-dev \
		make \
		pkg-config \
		wget \
		zlib1g-dev \
	'; \
	apt-get update; \
	apt-get install -y --no-install-recommends $buildDeps; \
	rm -rf /var/lib/apt/lists/*; \
	\
	export PREFIX='/usr/local'; \
	for ball in makemkv-oss makemkv-bin; do \
		wget -O "$ball.tgz" "http://www.makemkv.com/download/${ball}-${MAKEMKV_VERSION}.tar.gz"; \
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
	apt-mark manual \
		libavcodec57 \
		libqtdbus4 \
		libqtgui4 \
		libssl1.1 \
	; \
	apt-get purge -y --auto-remove $buildDeps

CMD ["makemkv"]
