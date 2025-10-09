#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.13.1

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.13.1/coredns_1.13.1_linux_amd64.tgz'; sha256='1693b2bc2091981bc870c89c69fba13bd97d985cb3486e0bc2e932d73964cca8' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.13.1/coredns_1.13.1_linux_arm64.tgz'; sha256='dd0fe9f11eb4a07efcfc33fda85174ce256ebb95ef71eea0ca05011616317107' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.13.1/coredns_1.13.1_linux_mips64le.tgz'; sha256='c55a85a90edb22ab527dde9e090ef062d3906ea1103f257775572cd6c7c3bdfc' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.13.1/coredns_1.13.1_linux_ppc64le.tgz'; sha256='8433a9b5cba2e94d90d599cd635cd83d87bbcbf304c72e8548edee5930b1ba7e' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.13.1/coredns_1.13.1_linux_riscv64.tgz'; sha256='36e3120c689d14d123803b862feb19fe7f6b94760f6dc1d3c44c5a596fb38d86' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.13.1/coredns_1.13.1_linux_s390x.tgz'; sha256='fc9b8266d06ae8fe85f48c7fed3a46334023773a582967e3bd78992e853b2b51' ;; \
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
