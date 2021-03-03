FROM python:3.8-slim-buster

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
	rm -rf /var/lib/apt/lists/*

# for "diffoscope --progress"
# https://pypi.org/project/progressbar33/
RUN pip install --no-cache-dir progressbar33==2.4

# https://pypi.org/project/diffoscope/
ENV DIFFOSCOPE_VERSION 168

RUN set -eux; \
	pip install --no-cache-dir "diffoscope == $DIFFOSCOPE_VERSION"; \
	diffoscope --version

CMD ["diffoscope"]
