#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.14.3

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.14.3/coredns_1.14.3_linux_amd64.tgz'; sha256='8cbd093a8d3ec18d9d35c743c556c7e8edba71bb81fdfe4f323c25d67b1992bf' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.14.3/coredns_1.14.3_linux_arm64.tgz'; sha256='930414c65664749b051535304c0e32da295d991c57863b223e0072299ca446b9' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.14.3/coredns_1.14.3_linux_mips64le.tgz'; sha256='3b3d9163e793da8938f9620585abb6ed9b21b03287fdef6a9e969be6f985e460' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.14.3/coredns_1.14.3_linux_ppc64le.tgz'; sha256='6ca6e44dc72744b8c600b4bd36ebb308c9e3ea09c7c8ea5ecfae279d005e5c00' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.14.3/coredns_1.14.3_linux_riscv64.tgz'; sha256='6c47cb6e8093889bab1e80af3d2e13807a6385d663a916b3873e9aa9ee2978a4' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.14.3/coredns_1.14.3_linux_s390x.tgz'; sha256='b08a90e9d05a46b46364765585fc1aa9f996b01e093e71ee14bab1de52c7c3fb' ;; \
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
