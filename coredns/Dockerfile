#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.14.6

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.14.6/coredns_1.14.6_linux_amd64.tgz'; sha256='4402578c8f7b95dac1d8258bfd13e7a9d30f70d7a53f396b02a6d6ca78d56152' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.14.6/coredns_1.14.6_linux_arm64.tgz'; sha256='a99987b82977a791e232fcb828133cb645130481cc36af6e06fbf938326d2c3e' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.14.6/coredns_1.14.6_linux_mips64le.tgz'; sha256='b8e10c011e1fd19ca98fd58b05adb4fec813bf7f4c71b8d7daa2d049f7fe5c29' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.14.6/coredns_1.14.6_linux_ppc64le.tgz'; sha256='9efbba07c6b6714fa66ab2a403d7dd1b8e1406189621bcd9229bbf40e94d4bc3' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.14.6/coredns_1.14.6_linux_riscv64.tgz'; sha256='cd7808b291e6f44347975ed552bfdc9afef46c2288107c33ad9732e907c68e7c' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.14.6/coredns_1.14.6_linux_s390x.tgz'; sha256='781477db09c3c7f143ad5b337b4363eb1cda9be0438fc6c2c8a9f1fecc40e1da' ;; \
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
