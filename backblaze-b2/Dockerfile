#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM python:3.12-alpine3.20

# https://pypi.org/project/b2/
ENV BACKBLAZE_B2_VERSION 4.1.0

RUN set -eux; \
	pip install --no-cache-dir "b2 == $BACKBLAZE_B2_VERSION"; \
	b2 version

CMD ["b2", "--help"]
