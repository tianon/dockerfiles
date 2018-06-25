FROM alpine:3.7

RUN apk add --no-cache \
		bash \
		bash-completion \
		ca-certificates \
		curl \
		gnupg \
		libressl \
		openssh-client \
		rsync \
		socat \
		tshark \
		wget \
		\
		bind-tools \
		iperf \
		iptables \
		iputils \
		net-tools

CMD ["bash", "--login", "-i"]
