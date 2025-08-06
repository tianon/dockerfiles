#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.12.3

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.12.3/coredns_1.12.3_linux_amd64.tgz'; sha256='3651317764a3f1a75a7b00e8295414c0391f9a6b6a140f0d6d7dd783ac5f3d12' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.12.3/coredns_1.12.3_linux_arm64.tgz'; sha256='1dfc8f56464be64e90b1bf84ec9714ce8ab3a6d265bc7a1307170c28809bc913' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.12.3/coredns_1.12.3_linux_mips64le.tgz'; sha256='6539d4e96c5716e0404d92bf2eb5bf787e11403cd9edff42d3acc39bfb8f853d' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.12.3/coredns_1.12.3_linux_ppc64le.tgz'; sha256='d48d34336642d8f7c7dc73863472a578bd188d4d7a31efdd6444ec922bd7c277' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.12.3/coredns_1.12.3_linux_riscv64.tgz'; sha256='9b43134d29fed68eafceebb68754bfe5964d627f7f0e5add7485bfb57b75d29f' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.12.3/coredns_1.12.3_linux_s390x.tgz'; sha256='fb98f5cea6f72ff065be23751b44f8b456370106dd2fe4176660750d094984ca' ;; \
		*) echo >&2 "error: unsupported architecture '$dpkgArch'"; exit 1 ;; \
	esac; \
	\
	aptMarkManual="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates wget; \
	\
	wget -O coredns.tgz "$url" --progress=dot:giga; \
	echo "$sha256 *coredns.tgz" | sha256sum --strict --check -; \
	tar -xvf coredns.tgz -C /usr/local/bin; \
	rm coredns.tgz; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$aptMarkManual" ] || apt-mark manual $aptMarkManual > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*; \
	\
	coredns --version

USER nobody:nogroup
CMD ["coredns"]
