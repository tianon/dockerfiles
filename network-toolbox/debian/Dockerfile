FROM debian:bullseye-slim

RUN set -eux; \
# dangit, wireshark-common!  *shakes fist*
	export DEBIAN_FRONTEND='noninteractive'; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		bash-completion \
		ca-certificates \
		curl \
		dnsutils \
		fio \
		gnupg dirmngr \
		inetutils-ping \
		ipcalc \
		iperf \
		iproute2 \
		iptables \
		libfcgi-bin \
		mtr-tiny \
		nbtscan \
		net-tools \
		netcat-openbsd \
		nmap \
		ntpdate \
		openssh-client \
		procps \
		rsync \
		siege \
		socat \
		traceroute \
		tshark \
		wget \
		whois \
	; \
	rm -rf /var/lib/apt/lists/*

CMD ["bash", "--login", "-i"]
