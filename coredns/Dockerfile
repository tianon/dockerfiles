#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.13.2

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.13.2/coredns_1.13.2_linux_amd64.tgz'; sha256='41f0ec378a84c324adb2a912b58761a061f4f1b77d814276ed0da68c2c235512' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.13.2/coredns_1.13.2_linux_arm64.tgz'; sha256='d74541d623c93841e3dd2332669b50def8875b64d316db02066930de992fafd4' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.13.2/coredns_1.13.2_linux_mips64le.tgz'; sha256='08d12bf93e13304863457c73f895c61b26c932e77ad45b65971cb48dbb3da129' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.13.2/coredns_1.13.2_linux_ppc64le.tgz'; sha256='c27990154b6f31cde9a33b7963b1a8a88101e2c63dc4c492d0d9fd358210f6fa' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.13.2/coredns_1.13.2_linux_riscv64.tgz'; sha256='aa33f5a079460df74a453d97440a08510fec1f24decdf450ee8c8217c7438c5c' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.13.2/coredns_1.13.2_linux_s390x.tgz'; sha256='d77131455ea15ab4ba68f914f1e75e7e5460d456f6d5b6cb9c936b554e702556' ;; \
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
