# based initially on https://hub.docker.com/r/didrocks/snapcraft/
FROM ubuntu:xenial

# enable multiverse as snapcraft cleanbuild does
RUN sed -i 's/ universe$/ universe multiverse/' /etc/apt/sources.list

# pin specific version so we can update with a natural cache bust
ENV SNAPCRAFT_VERSION 2.27.1

RUN apt-get update \
	&& apt-get install -y snapcraft=$SNAPCRAFT_VERSION \
	&& rm -rf /var/lib/apt/lists/*
