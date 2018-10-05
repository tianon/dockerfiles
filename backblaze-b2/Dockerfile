FROM python:3.6-alpine3.8

ENV BACKBLAZE_B2_VERSION 1.3.6

RUN set -eux; \
	pip install --no-cache-dir "b2 == $BACKBLAZE_B2_VERSION"

CMD ["b2", "--help"]
