FROM debian:stretch-slim

RUN set -eux; \
	dpkg --add-architecture i386; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		wine \
		wine32 \
		wine64 \
	; \
	rm -rf /var/lib/apt/lists/*
