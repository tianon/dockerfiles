#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.12.4

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.12.4/coredns_1.12.4_linux_amd64.tgz'; sha256='46dcee6d9b406310a2dbf793e414c4a999317ddacbdfc307215a006144592f8f' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.12.4/coredns_1.12.4_linux_arm64.tgz'; sha256='67fdaa45b622eed5d969aad300ce28d37b42da60010672b90fde41e1dceefcaa' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.12.4/coredns_1.12.4_linux_mips64le.tgz'; sha256='367591d4c16ba1b7f75de2e930ae7c63895068ed22324c79c07e628eb7c1cc2c' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.12.4/coredns_1.12.4_linux_ppc64le.tgz'; sha256='61882dbe7c3d6aa4ce00e8c3cc7c8415de28a6a421b946d4736199f8843702c0' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.12.4/coredns_1.12.4_linux_riscv64.tgz'; sha256='611cdcb68a60729e7432794498f9b8712f34c45866303ad8276a3fd25a4f82f6' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.12.4/coredns_1.12.4_linux_s390x.tgz'; sha256='476814c0d9a0ee1731f8f0e64881006b4fd8822e8e6354f05608a964cb76d3e0' ;; \
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
