#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM python:3.10-slim-bullseye

ENV BEETS_VERSION 2.0.0

RUN set -eux; \
	pip install --no-cache-dir "beets == $BEETS_VERSION"; \
	beet --version

CMD ["beet"]
