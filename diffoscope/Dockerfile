#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM python:3.10-slim-trixie

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libarchive13 \
		libmagic1 \
		unzip \
		xz-utils \
# xxd (xxd not available in path. Falling back to Python hexlify.)
		vim-common \
# readelf ('readelf' not available in path. Falling back to binary comparison.)
		binutils-multiarch \
	; \
	apt-get dist-clean

# https://pypi.org/project/diffoscope/
ENV DIFFOSCOPE_VERSION 312

RUN set -eux; \
	pip install --no-cache-dir "diffoscope[distro_detection,cmdline] == $DIFFOSCOPE_VERSION"; \
	diffoscope --version

CMD ["diffoscope"]
