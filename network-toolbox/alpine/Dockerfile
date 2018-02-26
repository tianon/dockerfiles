FROM alpine:3.7

RUN apk add --no-cache \
		bash \
		bash-completion \
		ca-certificates \
		curl \
		libressl \
		openssh-client \
		rsync \
		tshark \
		wget \
		\
		bind-tools \
		iptables \
		iputils \
		net-tools

CMD ["bash", "--login", "-i"]
