FROM python:3.8-alpine3.10

RUN set -eux; \
	apk add --no-cache --virtual .build-deps gcc libc-dev; \
# https://pypi.org/project/ruamel.yaml/
	pip install --no-cache-dir ruamel.yaml==0.16.5; \
	apk del .build-deps

COPY ymlfmt /usr/local/bin/
