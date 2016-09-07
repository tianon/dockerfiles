FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
		dnsutils \
		inetutils-ping \
		iproute2 \
		net-tools \
	&& rm -rf /var/lib/apt/lists/*
