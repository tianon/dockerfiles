FROM debian:stretch-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
		\
		dnsutils \
		inetutils-ping \
		iproute2 \
		iptables \
		net-tools \
	&& rm -rf /var/lib/apt/lists/*
