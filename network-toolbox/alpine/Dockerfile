FROM alpine:3.9

RUN apk add --no-cache \
		bash \
		bash-completion \
		bind-tools \
		ca-certificates \
		curl \
		gnupg \
		ipcalc \
		iperf \
		iptables \
		iputils \
		libressl \
		mtr \
		net-tools \
		nmap \
		openssh-client \
		rsync \
		socat \
		tshark \
		wget \
		whois
# TODO add "nbtscan" when we get to Alpine 3.10 (if it makes it out of edge for 3.10)

CMD ["bash", "--login", "-i"]
