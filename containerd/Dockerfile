#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# runtime deps
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*

# https://github.com/docker/docker/tree/HEAD/hack/dind
ENV DIND_COMMIT 65cfcc28ab37cb75e1560e4b4738719c07c6618e
# https://github.com/docker/docker/commit/65cfcc28ab37cb75e1560e4b4738719c07c6618e -- 2023-11-27T14:48:51.000+01:00 (@1701092931)
RUN set -eux; \
	wget -O /usr/local/bin/dind "https://github.com/docker/docker/raw/${DIND_COMMIT}/hack/dind"; \
	sh -n /usr/local/bin/dind; \
	chmod +x /usr/local/bin/dind

# https://github.com/opencontainers/runc/releases
ENV RUNC_VERSION 1.2.4
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/opencontainers/runc/releases/download/v1.2.4/runc.amd64'; sha256='e83565aa78ec8f52a4d2b4eb6c4ca262b74c5f6770c1f43670c3029c20175502' ;; \
		'i386') url='https://github.com/opencontainers/runc/releases/download/v1.2.4/runc.386'; sha256='41dda3ff784c611bc86acf16f3472f9663160809bf6be854998231e3e038df63' ;; \
		'arm64') url='https://github.com/opencontainers/runc/releases/download/v1.2.4/runc.arm64'; sha256='285f6c4c3de1d78d9f536a0299ae931219527b2ebd9ad89df5a1072896b7e82a' ;; \
		'armhf') url='https://github.com/opencontainers/runc/releases/download/v1.2.4/runc.armhf'; sha256='1aba471efcaf76393b308e23ff8013fbd2f60f920a2c7dc84e33b31dccc24ebf' ;; \
		'ppc64el') url='https://github.com/opencontainers/runc/releases/download/v1.2.4/runc.ppc64le'; sha256='141fa41c1f382483ccf374827f99c7843414fceb95e8ceb710aba8bac984d016' ;; \
		'riscv64') url='https://github.com/opencontainers/runc/releases/download/v1.2.4/runc.riscv64'; sha256='2b58f0f7d1450cba40e05e4c3ba7251702a785f19bff5bc7ff736004a9ef9424' ;; \
		's390x') url='https://github.com/opencontainers/runc/releases/download/v1.2.4/runc.s390x'; sha256='cb6f5692687f351325fbf67e9655563c83537918a40dfb5c864894f32f6115c3' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
# TODO $url.asc (see https://github.com/opencontainers/runc/releases)
	wget -O /usr/local/bin/runc "$url" --progress=dot:giga; \
	echo "$sha256 */usr/local/bin/runc" | sha256sum --strict --check -; \
	chmod +x /usr/local/bin/runc; \
	runc --version

# https://github.com/containerd/containerd/releases
ENV CONTAINERD_VERSION 2.0.2
RUN set -eux; \
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/containerd/containerd/releases/download/v2.0.2/containerd-2.0.2-linux-amd64.tar.gz'; sha256='9bd5b6a1bdf505d520d9a329c520258ed0a17faa9fe3db12712ee858ad59aae3' ;; \
		'arm64') url='https://github.com/containerd/containerd/releases/download/v2.0.2/containerd-2.0.2-linux-arm64.tar.gz'; sha256='14a2a9f7f75f73e5bcfb8b183d0b84830c54b98ef8c5f6ed70e51f1a230c673e' ;; \
		'ppc64el') url='https://github.com/containerd/containerd/releases/download/v2.0.2/containerd-2.0.2-linux-ppc64le.tar.gz'; sha256='1b19d31bb8a7f9d26d9b50675e78f397d0b01fa635c33cca456f91c412fa6df1' ;; \
		'riscv64') url='https://github.com/containerd/containerd/releases/download/v2.0.2/containerd-2.0.2-linux-riscv64.tar.gz'; sha256='97a50754f9e1375b6129f7d625733b7d5e0bc30a51aab99fdaee660eb9b700ad' ;; \
		's390x') url='https://github.com/containerd/containerd/releases/download/v2.0.2/containerd-2.0.2-linux-s390x.tar.gz'; sha256='4e578e9c0c3f4718df0c76deaa2037d2c5d1160d0d0138fa9df4b1cc28f51fe7' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
	wget -O containerd.tar.gz "$url" --progress=dot:giga; \
	echo "$sha256 *containerd.tar.gz" | sha256sum --strict --check -; \
	tar -xvf containerd.tar.gz -C /usr/local/; \
	rm containerd.tar.gz; \
	containerd --version

RUN set -eux; \
	mkdir -p /run/containerd /var/lib/containerd; \
	chmod 1777 /run/containerd /var/lib/containerd

VOLUME /var/lib/containerd

# add an entrypoint that does clever things if the container is run as non-root (cannot run containers, but content/image stores should work fine)
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["containerd"]

# the entrypoint will try to automatically determine intent based on uid/gid (and include the "dind" wrapper automatically)
# if it does not, use "docker run ... dind containerd" if you want to run real containers (with "--privileged")
