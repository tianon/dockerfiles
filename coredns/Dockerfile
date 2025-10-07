#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.13.0

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.13.0/coredns_1.13.0_linux_amd64.tgz'; sha256='42206457f56c1c1a9e43ee3210f5f6e964f0348e0610c12bada210ac6cf59dcc' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.13.0/coredns_1.13.0_linux_arm64.tgz'; sha256='a1cbf8adf71ce4a0629cccfb3de07b5bbaff310f6d28505f0f43ec740b098404' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.13.0/coredns_1.13.0_linux_mips64le.tgz'; sha256='1ab7d29f85060d4595db4b2d510724aef6d1130865bdb4256f3e1be675b39824' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.13.0/coredns_1.13.0_linux_ppc64le.tgz'; sha256='d6d037661f76422b27c748088442836061c0fbfaf8e432ef6d2b273587e317ca' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.13.0/coredns_1.13.0_linux_riscv64.tgz'; sha256='6e332e4438341baed084d8c1929c9c65e6e85b8ae8ca440be9838ab879a7336c' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.13.0/coredns_1.13.0_linux_s390x.tgz'; sha256='d0c56358209b85604b6c93a6898ed4407d2e311dfd2e8f297ab0baf4d8b183d1' ;; \
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
	apt-get dist-clean; \
	\
	coredns --version

USER nobody:nogroup
CMD ["coredns"]
