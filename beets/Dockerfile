#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM python:3.9-slim-bullseye

ENV BEETS_VERSION 1.6.0

RUN set -eux; \
	pip install --no-cache-dir "beets == $BEETS_VERSION"; \
	beet --version

CMD ["beet"]
