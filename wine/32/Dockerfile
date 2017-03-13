FROM debian:stretch-slim

RUN dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		wine32 \
		wine \
	&& rm -rf /var/lib/apt/lists/*
