FROM python:2-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*

# https://pypi.org/project/gmusicapi/
ENV GMUSICAPI_VERSION 11.0.2

RUN pip install --no-cache-dir "gmusicapi == $GMUSICAPI_VERSION"

# https://github.com/stevenewbs/gmpydl/commits/master
# https://github.com/stevenewbs/gmpydl/releases
ENV GMPYDL_COMMIT f61972859729bd35d1f0d27e9a4a13e455b371d9

RUN set -eux; \
	wget -O /usr/local/bin/gmpydl "https://github.com/stevenewbs/gmpydl/raw/$GMPYDL_COMMIT/gmpydl.py"; \
	chmod +x /usr/local/bin/gmpydl

ENTRYPOINT ["gmpydl"]
