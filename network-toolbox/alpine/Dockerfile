FROM alpine:3.18

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
		net-tools \
		nmap \
		openssh-client \
		openssl \
		rsync \
		socat \
		ssh-audit \
		wget \
		whois \
# tshark isn't available on arm32v6 (Alpine's armhf), for some reason (as of 2023-09-16, Alpine 3.18):
		$([ "$apkArch" = 'armhf' ] || echo tshark) \
# "git" is reasonably small on Alpine (adds ~6MiB)
		git \
	;
# TODO add "nbtscan" in Alpine 3.19 👀 (https://git.alpinelinux.org/aports/commit/community/nbtscan?id=d865781209912eadeb5d000d742fee8b8e97aab0)
# https://pkgs.alpinelinux.org/packages?name=nbtscan&branch=edge&arch=x86_64

CMD ["bash", "--login", "-i"]
