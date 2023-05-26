FROM alpine:3.18

RUN apk add --no-cache \
		bash \
		bash-completion \
		bind-tools \
		ca-certificates \
		curl \
		fcgi \
		fio \
		gnupg \
		iftop \
		ipcalc \
		iperf \
		iptables \
		iputils \
		mtr \
		net-tools \
		nmap \
		openssh-client \
		openssl \
		rsync \
		socat \
		ssh-audit \
		tshark \
		wget \
		whois
# TODO add "nbtscan" when we get to Alpine 3.18 (if it makes it out of testing)
# https://pkgs.alpinelinux.org/packages?name=nbtscan&branch=edge&arch=x86_64

CMD ["bash", "--login", "-i"]
