#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.14.1

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.14.1/coredns_1.14.1_linux_amd64.tgz'; sha256='186ebc9a8025ad6661e566ae7beadba9a81063d5c30c39961d8dee16446417d5' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.14.1/coredns_1.14.1_linux_arm64.tgz'; sha256='2784b6bde0f9caf17b462aefdc6d321d76fec7129bed1a2fce2c79c370b34878' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.14.1/coredns_1.14.1_linux_mips64le.tgz'; sha256='a7821cb3862831be204ee84a27e19a78255cb03f6c466208f71fd3fb7c5b6e33' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.14.1/coredns_1.14.1_linux_ppc64le.tgz'; sha256='5f40c8a9bc858de1aad04c1e33afc808d37f9add68a3b2a831416636548ce50b' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.14.1/coredns_1.14.1_linux_riscv64.tgz'; sha256='b043c7502fe4cfc59e6a7440fa4edc9ddfd15b9d88f6a82866b275a9d5af96dd' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.14.1/coredns_1.14.1_linux_s390x.tgz'; sha256='6e412dfa6ab2aef819eeb25dc815ba4fb7f2eecd714b19efd5cc3e84b1d6ef6e' ;; \
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
