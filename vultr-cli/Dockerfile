#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.11.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.11.0/vultr-cli_v3.11.0_linux_amd64.tar.gz'; sha256='c7794d06cca80c41d2b42b692d040f62245c76bac86e3ed8fa08004e163c8935' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.11.0/vultr-cli_v3.11.0_linux_arm32-v6.tar.gz'; sha256='7bcdc8f76a4d25de45f1014583c7f8937415ef11f41e6ef7ab8942975234a1c3' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.11.0/vultr-cli_v3.11.0_linux_arm32-v7.tar.gz'; sha256='c754c7b5c907d5e7770d40c41efe99bdebeee9189ef5793e2b9c2fa82002a7ea' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.11.0/vultr-cli_v3.11.0_linux_arm64.tar.gz'; sha256='7112253bb09cefdbc2a7ff5bc90d9f4be788e4f2843ff86837c1b5f20a50b9ac' ;; \
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
