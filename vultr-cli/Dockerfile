#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.22

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.6.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.6.0/vultr-cli_v3.6.0_linux_amd64.tar.gz'; sha256='48c45dd806ba51eefe3f7bc70a25b63ac568c33f67ed0bd152407e1a43961dc7' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.6.0/vultr-cli_v3.6.0_linux_arm32-v6.tar.gz'; sha256='2aea6eb93ef870ff4f633f879f5429968887eee6c9b16ce9e0c7fe5501a2af07' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.6.0/vultr-cli_v3.6.0_linux_arm32-v7.tar.gz'; sha256='7e9a11e1638c489eb81c006dc64e2f626f6b7dc65a27d2a87d2df56e2048b4bd' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.6.0/vultr-cli_v3.6.0_linux_arm64.tar.gz'; sha256='6aac2397a37ed9d4e5175216a5959875f09aa2f3c3d3ef38efb6d04c4a63f0cc' ;; \
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
