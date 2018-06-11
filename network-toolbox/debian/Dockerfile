FROM debian:stretch-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		bash-completion \
		ca-certificates \
		curl \
		gnupg dirmngr \
		netcat-openbsd \
		openssh-client \
		procps \
		rsync \
		socat \
		tshark \
		wget \
		\
		dnsutils \
		inetutils-ping \
		iproute2 \
		iptables \
		net-tools \
		traceroute \
	&& rm -rf /var/lib/apt/lists/*

CMD ["bash", "--login", "-i"]
