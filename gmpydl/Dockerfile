FROM python:3-alpine3.12

# https://pypi.org/project/gmusicapi/
ENV GMUSICAPI_VERSION 13.0.0

RUN set -ex; \
	\
	apk add --no-cache --virtual .build-deps \
		gcc \
		libxml2-dev \
		libxslt-dev \
		musl-dev \
	; \
	\
	pip install --no-cache-dir "gmusicapi == $GMUSICAPI_VERSION"; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --recursive /usr/local \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)"; \
	apk add --virtual .gmusicapi-rundeps $runDeps; \
	apk del .build-deps

# https://github.com/stevenewbs/gmpydl/commits/master
# https://github.com/stevenewbs/gmpydl/releases
ENV GMPYDL_COMMIT 3022a6613547e1b08ea884a9323d6f0e2cf91a43

RUN set -eux; \
	wget -O /usr/local/bin/gmpydl "https://github.com/stevenewbs/gmpydl/raw/$GMPYDL_COMMIT/gmpydl.py"; \
	chmod +x /usr/local/bin/gmpydl

CMD ["gmpydl"]
