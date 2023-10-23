#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.18

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 2.19.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v2.19.0/vultr-cli_v2.19.0_linux_amd64.tar.gz'; sha256='4b19b64e5dd45c4a6b88692c726ccb6edc162f228f0e7b80acc3a43326e94665' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v2.19.0/vultr-cli_v2.19.0_linux_arm32-v6.tar.gz'; sha256='ac5293e8c8ec45569d1d7085d34fa1b5d45a2f983cc85cd63bd07ce872ee2843' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v2.19.0/vultr-cli_v2.19.0_linux_arm32-v7.tar.gz'; sha256='d40dad21038f721f4c14f45e4879ff85bcec1b9c19c284ee90c83316a7c641d4' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v2.19.0/vultr-cli_v2.19.0_linux_arm64.tar.gz'; sha256='dfefbd8478626d67d400b9c523ee818ee04c2c0f1c39738358d238ef33a18726' ;; \
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
