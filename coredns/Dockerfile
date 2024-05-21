#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.11.1

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_amd64.tgz'; sha256='f96cdee0934c5c12a28bb0fb080bed688fdd7bfdeae2f64984f02bdec2d65498' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_arm64.tgz'; sha256='725ee697b45fff0c77d63b931977090aa0e93a617a782eac1bc4a996ce0248e2' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_mips64le.tgz'; sha256='b10ac8070e147295d482cb491bd81bcfda28f49bc3ff6c6b41941c4e94e0f4e3' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_ppc64le.tgz'; sha256='8af0793d99927bd71ff69911f69b2c4828ec29dbcb61dcafd4f85d62699855eb' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_riscv64.tgz'; sha256='2d0e2d7d0804dce05b07758500b3033ff659a1a507a3061979764119bd0024dc' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_s390x.tgz'; sha256='15481164079b78f1c18ced09449b745955365a27a3e35d1db4393ef301303f3d' ;; \
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
	apt-get purge -y --auto-remove; \
	rm -rf /var/lib/apt/lists/*; \
	\
	coredns --version

USER nobody:nogroup
CMD ["coredns"]
