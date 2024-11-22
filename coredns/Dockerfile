#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bookworm-slim

# https://github.com/coredns/coredns/releases
ENV COREDNS_VERSION 1.12.0

RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') url='https://github.com/coredns/coredns/releases/download/v1.12.0/coredns_1.12.0_linux_amd64.tgz'; sha256='c835bd5e9ba9a98df9631e5a3f0effc60f03ccb9c687c91ae2c85ebf7ab1fc34' ;; \
		'arm64') url='https://github.com/coredns/coredns/releases/download/v1.12.0/coredns_1.12.0_linux_arm64.tgz'; sha256='4946f3110fee46e53acfaef51ebc1a5a844b50411974fd652fa6935128f56271' ;; \
		'mips64el') url='https://github.com/coredns/coredns/releases/download/v1.12.0/coredns_1.12.0_linux_mips64le.tgz'; sha256='c97131bf2bbd9170bc000fe1d105530cec06ad2ba80a5fbf62145e4aac172b06' ;; \
		'ppc64el') url='https://github.com/coredns/coredns/releases/download/v1.12.0/coredns_1.12.0_linux_ppc64le.tgz'; sha256='4d4fe082a10922e7a3c6e14e0be16f0fa176b1f561a47095eb1707e77041854a' ;; \
		'riscv64') url='https://github.com/coredns/coredns/releases/download/v1.12.0/coredns_1.12.0_linux_riscv64.tgz'; sha256='7b8cd49c413ffdba3c4d4cfdd452c6b67c626f023071b2b3acbcccf623afb603' ;; \
		's390x') url='https://github.com/coredns/coredns/releases/download/v1.12.0/coredns_1.12.0_linux_s390x.tgz'; sha256='52bc86cbcaeb51379dfa987674ed0fc99f32e1bd8f771d450c367f1cdc4da363' ;; \
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
