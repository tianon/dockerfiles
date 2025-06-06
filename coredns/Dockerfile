#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.12.2

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.12.2/coredns_1.12.2_linux_amd64.tgz'; sha256='95c03c2e8ef56e2ec3cfbb2970504d7abdc07666b9dde8c5dc9d72d34dff756e' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.12.2/coredns_1.12.2_linux_arm64.tgz'; sha256='3e2117d24e7e0292d60578809ce4ad1e517cd957bffe595241826cff6cdb6c9b' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.12.2/coredns_1.12.2_linux_mips64le.tgz'; sha256='ee35955c7220940c7341b4ecb7de086bfbf5c3ca41b0f74c443da08098f5f2d0' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.12.2/coredns_1.12.2_linux_ppc64le.tgz'; sha256='cd0ee03fe19af4f9684ea1e4f37dd496526a9dd92d9345b9cadb0ecc27fe11c4' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.12.2/coredns_1.12.2_linux_riscv64.tgz'; sha256='f2a88f7da84be6a7938510e17bd1fad0a371c7bcc9ba7e79bf705d287a80220f' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.12.2/coredns_1.12.2_linux_s390x.tgz'; sha256='1b731c5e62fadc2bd9395cf2a4a8917d4732ba94912732274395a0a48066cbe8' ;; \
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
