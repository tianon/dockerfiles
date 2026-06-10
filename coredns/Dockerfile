#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.14.4

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.14.4/coredns_1.14.4_linux_amd64.tgz'; sha256='5b0e6a6a8b97bdcaec65baa70e83ca88ce03ab852355c656e3f7953405cfe36e' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.14.4/coredns_1.14.4_linux_arm64.tgz'; sha256='b3491ed0fbe530a549640a4073d90037ffafa483f007936e1943c1ae0def7325' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.14.4/coredns_1.14.4_linux_mips64le.tgz'; sha256='80f36ce2a308223d54642d50b05fd0356e9417ac71261cd087b29a048b5c290d' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.14.4/coredns_1.14.4_linux_ppc64le.tgz'; sha256='7bc42ea8fd204e6ad64e64b5753bf5607e3bcf536ab2af973a4ae3e7976f29a0' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.14.4/coredns_1.14.4_linux_riscv64.tgz'; sha256='210d5405f952a70fdbd694851e10034c883ff7c19eb4deea9018716183700f1a' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.14.4/coredns_1.14.4_linux_s390x.tgz'; sha256='905ec9b04defa74c46b0cd4a5cc25feaa7dbacd9b86b82fc2d34d37fc1266d13' ;; \
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
