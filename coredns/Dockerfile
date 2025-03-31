#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.12.1

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.12.1/coredns_1.12.1_linux_amd64.tgz'; sha256='886206d686363cd7d71c62ac47287692b954da3dfc9bcbffedd80d4b69358001' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.12.1/coredns_1.12.1_linux_arm64.tgz'; sha256='f1c9030a7fbf3c9f5421894211b3bee62de7e77d260fc4282a0d8104376b6300' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.12.1/coredns_1.12.1_linux_mips64le.tgz'; sha256='8ffebbcef1575bc92a61c0b88697d055f457e78274ebbf1e3b24bae88c404147' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.12.1/coredns_1.12.1_linux_ppc64le.tgz'; sha256='2259fde936f3a6a0d8716e27ba5c84b2a9d782d693b6b069a701a0df59913a82' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.12.1/coredns_1.12.1_linux_riscv64.tgz'; sha256='d3ed8e443b071cc353bc3d2e5e5865acb4f07393ad4571f36a580204b04e2108' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.12.1/coredns_1.12.1_linux_s390x.tgz'; sha256='140064b9b482314b71cd43c7c4937ebd38068eb9ca09ef98bd947b1ab8829a89' ;; \
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
