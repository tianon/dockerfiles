#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.14.7

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.14.7/coredns_1.14.7_linux_amd64.tgz'; sha256='9a09356438c6d9591cb80011a2a7a52f87fc3a113f6690e41f243f98b98faac9' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.14.7/coredns_1.14.7_linux_arm64.tgz'; sha256='bf26782d19b5340e3e6cb50f1ed6df72f58e4a30932c79d167f0f0a8b1e92e16' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.14.7/coredns_1.14.7_linux_mips64le.tgz'; sha256='7b71975d3ee1ee64db35805e4ff2d506454467ff9af70581b1a5511025a3ab8e' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.14.7/coredns_1.14.7_linux_ppc64le.tgz'; sha256='eded4a1cc71c422643a042ab5bb1685104dc32e17324955c39756839a4be01a1' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.14.7/coredns_1.14.7_linux_riscv64.tgz'; sha256='d751f467d70cebbf56656455265939b2ae84323b6ee6d0cc2ce92c69d1eef918' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.14.7/coredns_1.14.7_linux_s390x.tgz'; sha256='930302ba8a21577ce76308b0c5693df1755f9d42431d8fad032322fe8ff97b9d' ;; \
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
