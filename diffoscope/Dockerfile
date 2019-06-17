FROM python:3-slim

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
RUN pip install progressbar33==2.4

ENV DIFFOSCOPE_VERSION 115

RUN pip install diffoscope==$DIFFOSCOPE_VERSION

CMD ["diffoscope"]
