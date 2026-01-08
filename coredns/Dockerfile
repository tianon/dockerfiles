#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.14.0

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.14.0/coredns_1.14.0_linux_amd64.tgz'; sha256='cbfa2bf732b329fe73fe2450ad3e3ebde67edffdff4a023d705f7534c904f624' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.14.0/coredns_1.14.0_linux_arm64.tgz'; sha256='279f762ffb692b41e7c41fb3033115d28a7d3d1c6f690d83b1a45ed0d8750fe9' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.14.0/coredns_1.14.0_linux_mips64le.tgz'; sha256='01d135afbcf93719c5ce3f30fe95ea023e74b8850431319507619786101aa8af' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.14.0/coredns_1.14.0_linux_ppc64le.tgz'; sha256='8f91373fac2a3919c6e467e224525f5fcfcfa6628e2bee87aca8802540d72d8b' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.14.0/coredns_1.14.0_linux_riscv64.tgz'; sha256='3212f8f7fdb58d365066f1aa16f43198a07b257d7bd956f2e096f955f31552fa' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.14.0/coredns_1.14.0_linux_s390x.tgz'; sha256='18dc6c541d263bc187f4b8013c4b94733baef9f036c2758521f728d0f4f35aa7' ;; \
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
