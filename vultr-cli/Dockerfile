#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.0.1

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.1/vultr-cli_v3.0.1_linux_amd64.tar.gz'; sha256='839d9289989974e29f195e58c2d9a18b84ec752cf817d1562be16c9d54569abd' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.1/vultr-cli_v3.0.1_linux_arm32-v6.tar.gz'; sha256='9cc976df4e3431b576af3de6df9e73bc29c1d2910d9caf08d839090f45baf72f' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.1/vultr-cli_v3.0.1_linux_arm32-v7.tar.gz'; sha256='4c383d13fc76dffa6b14f9356afda3e76d85b850544b186d6d5ea52f7f11371b' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.1/vultr-cli_v3.0.1_linux_arm64.tar.gz'; sha256='cb35e41ae720224a2e83e4845e3cb56fbeaa862e885698c2cb959a08d0c1fab3' ;; \
		*) echo >&2 "error: unsupported architecture: '$apkArch'"; exit 1 ;; \
	esac; \
	\
	wget -O vultr.tgz "$url"; \
	echo "$sha256 *vultr.tgz" | sha256sum -c -; \
	\
	tar -xvf vultr.tgz -C /usr/local/bin; \
	rm vultr.tgz; \
	\
	VULTR_API_KEY=fake vultr-cli version

CMD ["vultr-cli", "--help"]
