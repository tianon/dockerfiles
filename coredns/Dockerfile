#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.14.2

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.14.2/coredns_1.14.2_linux_amd64.tgz'; sha256='2f08896df9d28ea0cd2294037e6d66e82f996b504e4901b791be8a3ae042029b' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.14.2/coredns_1.14.2_linux_arm64.tgz'; sha256='c723a8c5194919c600bbb0f5f4c95cd3c42472bd9aeb2cac7038ab02be910709' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.14.2/coredns_1.14.2_linux_mips64le.tgz'; sha256='a42bcb2fd6271930b4bb26515ef381b623775e5daf8ab1afdecdb132cfb2ec16' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.14.2/coredns_1.14.2_linux_ppc64le.tgz'; sha256='cf717eb13e0e2fdf291bf4b3abc96a66d041ad47141112cce2b50c78c0dba62b' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.14.2/coredns_1.14.2_linux_riscv64.tgz'; sha256='d952cd5e2b8573efad6ca110da29ac7a0b317d3e28dc8990d0c25093d20a3e0a' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.14.2/coredns_1.14.2_linux_s390x.tgz'; sha256='f3870650b1f9234783d90844872ac155f8ddca579971e9dc4c67b8cc2488a949' ;; \
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
