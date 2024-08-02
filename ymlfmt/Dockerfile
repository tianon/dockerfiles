#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM python:3.12-alpine3.20

RUN set -eux; \
	apk add --no-cache --virtual .build-deps gcc libc-dev; \
# https://pypi.org/project/ruamel.yaml/
	pip install --no-cache-dir 'ruamel.yaml == 0.18.6'; \
	apk del --no-network .build-deps

COPY ymlfmt /usr/local/bin/

COPY test-*.yml /tmp/
RUN set -eux; \
	diff="$(ymlfmt -d '/tmp/test-out.yml')"; \
	[ -z "$diff" ]; \
	in="$(ymlfmt '/tmp/test-in.yml')"; \
	out="$(cat '/tmp/test-out.yml')"; \
	[ "$in" = "$out" ]
