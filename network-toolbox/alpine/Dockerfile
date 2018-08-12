FROM alpine:3.8

RUN apk add --no-cache \
		bash \
		bash-completion \
		bind-tools \
		ca-certificates \
		curl \
		gnupg \
		iperf \
		iptables \
		iputils \
		libressl \
		net-tools \
		openssh-client \
		rsync \
		socat \
		tshark \
		wget
# TODO add "nbtscan" when we get to Alpine 3.9 (if it makes it out of edge for 3.9)

CMD ["bash", "--login", "-i"]
