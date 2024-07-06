#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.3.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.3.0/vultr-cli_v3.3.0_linux_amd64.tar.gz'; sha256='407051b01556e260f0b4a6268d7c2f990c0968a058a4754bd6e98e6fe5cbaef0' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.3.0/vultr-cli_v3.3.0_linux_arm32-v6.tar.gz'; sha256='954aa3a27d373c807f1493d165b5e938b18b42b5efa3c229da3f6b401be1de67' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.3.0/vultr-cli_v3.3.0_linux_arm32-v7.tar.gz'; sha256='663bb6633d3dc62d133bafee439b9c6d57e143967b75f9574046c44b2392a587' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.3.0/vultr-cli_v3.3.0_linux_arm64.tar.gz'; sha256='9177a6e21b225991ed4b268c96d68e077d67d80de9a8d473b7fcf4b826bade15' ;; \
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
