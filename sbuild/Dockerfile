FROM debian:stretch-slim

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		sbuild schroot \
		\
		debootstrap \
		wget ca-certificates \
	; \
	rm -rf /var/lib/apt/lists/*
