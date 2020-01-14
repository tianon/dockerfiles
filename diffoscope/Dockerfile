FROM python:3.7-slim-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
		libarchive13 \
		libmagic1 \
		unzip \
		xz-utils \
# xxd (xxd not available in path. Falling back to Python hexlify.)
		vim-common \
# readelf ('readelf' not available in path. Falling back to binary comparison.)
		binutils-multiarch \
	&& rm -rf /var/lib/apt/lists/*

# for "diffoscope --progress"
RUN pip install --no-cache-dir progressbar33==2.4

ENV DIFFOSCOPE_VERSION 134

RUN pip install --no-cache-dir diffoscope==$DIFFOSCOPE_VERSION

CMD ["diffoscope"]
