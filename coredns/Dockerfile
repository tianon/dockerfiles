#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.15.0

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.15.0/coredns_1.15.0_linux_amd64.tgz'; sha256='2495c5b8f3fab6d0a336c397f1227b75406d86e6ec7125744a29df9e936ab8cd' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.15.0/coredns_1.15.0_linux_arm64.tgz'; sha256='73a5bf107c9791d57741ccd59ad138ab00bcd5bb3f62e2e28c999f5c047334a4' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.15.0/coredns_1.15.0_linux_mips64le.tgz'; sha256='705353c504b39fdedd6a329a959bb0ea33df7cc25c722933bdaebc68dc080fff' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.15.0/coredns_1.15.0_linux_ppc64le.tgz'; sha256='0e8e4417d8f9a4098687bca9665b887f34cd1b298b974ad62b83e168335d101d' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.15.0/coredns_1.15.0_linux_riscv64.tgz'; sha256='1365dd7ed041360069e6402d90ec934c8f7deb12dd6e7e256e8435fabb8eab2f' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.15.0/coredns_1.15.0_linux_s390x.tgz'; sha256='db7592569e20f91979cf3467d56b0da2a1dbb95b5578fa984e9fa1865cc15e46' ;; \
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
