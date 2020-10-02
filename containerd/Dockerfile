FROM debian:buster-slim

# runtime deps
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.0.0-rc92

RUN set -eux; \
	wget -O /usr/local/bin/runc "https://github.com/opencontainers/runc/releases/download/v${RUNC_VERSION}/runc.amd64" --progress=dot:giga; \
# TODO .asc / .sha256sum
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 1.4.1

RUN set -eux; \
	wget -O containerd.tar.gz "https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/containerd-${CONTAINERD_VERSION}-linux-amd64.tar.gz" --progress=dot:giga; \
	tar -xvf containerd.tar.gz -C /usr/local/; \
	rm containerd.tar.gz; \
	containerd --version

RUN set -eux; \
	mkdir -p /run/containerd /var/lib/containerd; \
	chmod 777 /run/containerd /var/lib/containerd

COPY non-root-containerd.sh /usr/local/bin/

CMD ["non-root-containerd.sh"]
