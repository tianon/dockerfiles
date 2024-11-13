#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.11.4

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.11.4/coredns_1.11.4_linux_amd64.tgz'; sha256='3dd1b565a6b72e04f7c19dc461ffcc7b8e013d520569aa163312384a5be307e5' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.11.4/coredns_1.11.4_linux_arm64.tgz'; sha256='54cf9dd7c2af46072b12e8bf0412a2f2d42098064ed2d75d746028b73ede455d' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.11.4/coredns_1.11.4_linux_mips64le.tgz'; sha256='a8d8f74b77b05479da91e70be2649ed8f0341b79ae7c0f6cc7c3ef7dfabe5ce1' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.11.4/coredns_1.11.4_linux_ppc64le.tgz'; sha256='bd0c76587bc8f4907d1b5d27963f9f38b72c79c922ecb94f7dcc40d723b051d6' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.11.4/coredns_1.11.4_linux_riscv64.tgz'; sha256='7625961011878d0dcdf9ddd06d5b3875682f4654450c5ff61c213a83c88ce0f3' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.11.4/coredns_1.11.4_linux_s390x.tgz'; sha256='083c26a3f821d66275d4cd4cad8767baab8b95810ffdf05b88115393d1d4c090' ;; \
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
