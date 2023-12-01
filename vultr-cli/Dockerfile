#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.18

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 2.21.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v2.21.0/vultr-cli_v2.21.0_linux_amd64.tar.gz'; sha256='5d62519e82ca4389a64b650f01ce7e5b5b57797e74c8331e8980da5513271734' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v2.21.0/vultr-cli_v2.21.0_linux_arm32-v6.tar.gz'; sha256='ae9cf5946b460be897ac550c1e328343359cf4d38754fa970a8e52922fb32fa0' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v2.21.0/vultr-cli_v2.21.0_linux_arm32-v7.tar.gz'; sha256='f1e98aec2f1f0e6a5cc36d798b93596917b88ce92e242d420ddcdb12dee9d45b' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v2.21.0/vultr-cli_v2.21.0_linux_arm64.tar.gz'; sha256='398cac4c6ff4f6c10b2b76dd1d0a62287b145fdf2bb206961ac6c2cffe3eb68b' ;; \
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
