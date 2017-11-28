FROM python:3.6-alpine3.6

RUN set -eux; \
	apk add --no-cache --virtual .build-deps gcc libc-dev; \
# https://pypi.org/project/ruamel.yaml/
	pip install ruamel.yaml==0.15.34; \
	apk del .build-deps

COPY ymlfmt /usr/local/bin/
