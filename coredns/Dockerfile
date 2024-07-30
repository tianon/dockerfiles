#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.11.3

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.11.3/coredns_1.11.3_linux_amd64.tgz'; sha256='6af4d6a5412734417378f778343c4fba363a61ae027060675123d4296f5a8ee5' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.11.3/coredns_1.11.3_linux_arm64.tgz'; sha256='f10161d95585a8f1bbd967f9fd8004fc8aee97963b7180e1b8e6072293c42a54' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.11.3/coredns_1.11.3_linux_mips64le.tgz'; sha256='4c35768b57bfb4f1934611876ccd62963a9929c7ea29f0191e7e15a6f0160e69' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.11.3/coredns_1.11.3_linux_ppc64le.tgz'; sha256='f4d3ac8f7032f7d7160e5c1df3a6d6a6c37f84637dba50014d21f5f9492d357e' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.11.3/coredns_1.11.3_linux_riscv64.tgz'; sha256='c080bd5210b33a0659f3f0a1cc21ee3ea2f9bdb8802563d693765b5689a8fa9d' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.11.3/coredns_1.11.3_linux_s390x.tgz'; sha256='acf94127dd3e376d9f2bc20d7b6271ebe72fcc7f5eba32e45911d8e725609911' ;; \
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
