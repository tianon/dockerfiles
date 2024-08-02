FROM alpine:3.20

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	apk add --no-cache \
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
		jq \
		mtr \
		nbtscan \
		net-tools \
		nmap \
		openssh-client \
		openssl \
		rsync \
		socat \
		ssh-audit \
		wget \
		whois \
		wireguard-tools \
# tshark isn't available on arm32v6 (Alpine's armhf):
# https://git.alpinelinux.org/aports/tree/community/wireshark/APKBUILD?h=3.19-stable&id=bb857f3ce0b980f56f6a75f9d9a6fde9f48dfd36#n11
		$([ "$apkArch" = 'armhf' ] || echo tshark) \
# "git" is reasonably small on Alpine (adds ~6MiB)
		git \
	;

CMD ["bash", "--login", "-i"]
