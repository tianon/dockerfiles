FROM debian:stretch-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		wine64 \
		wine \
	&& rm -rf /var/lib/apt/lists/*
