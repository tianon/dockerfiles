#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.2.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.2.0/vultr-cli_v3.2.0_linux_amd64.tar.gz'; sha256='4627a2f4dd531798b2b1db18b1557b3d1e58566cc637832a4c42ee492f90712a' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.2.0/vultr-cli_v3.2.0_linux_arm32-v6.tar.gz'; sha256='4fd11d35f5b4da1b82e8af8a1927c33aa3de7f8eff52d72b5fd817a252ad2882' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.2.0/vultr-cli_v3.2.0_linux_arm32-v7.tar.gz'; sha256='8f8bd137fe4ebe430bab0afcfd96f4ac52d0b6e5715f682ddf39e05043702bd8' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.2.0/vultr-cli_v3.2.0_linux_arm64.tar.gz'; sha256='ee728b2798cc942d37b027941a2b4159399fd7cd61cc8bf4b3c19aa91781353e' ;; \
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
