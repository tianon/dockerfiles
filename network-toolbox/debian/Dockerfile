FROM debian:stretch-slim

RUN set -eux; \
# dangit, wireshark-common!  *shakes fist*
	export DEBIAN_FRONTEND='noninteractive'; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		bash-completion \
		ca-certificates \
		curl \
		dnsutils \
		gnupg dirmngr \
		inetutils-ping \
		ipcalc \
		iperf \
		iproute2 \
		iptables \
		mtr-tiny \
		nbtscan \
		net-tools \
		netcat-openbsd \
		nmap \
		openssh-client \
		procps \
		rsync \
		socat \
		traceroute \
		tshark \
		wget \
		whois \
	; \
	rm -rf /var/lib/apt/lists/*

CMD ["bash", "--login", "-i"]
