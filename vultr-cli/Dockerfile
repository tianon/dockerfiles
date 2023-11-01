#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.18

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 2.20.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v2.20.0/vultr-cli_v2.20.0_linux_amd64.tar.gz'; sha256='246b35d4a3ac4797b0653b0f68c87e08bb3226ed69d9d1974c194c3a97913736' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v2.20.0/vultr-cli_v2.20.0_linux_arm32-v6.tar.gz'; sha256='4e792b747fcf4e236c524f5e5b4a6d708806c579c30a3c637477baedee1dd9ea' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v2.20.0/vultr-cli_v2.20.0_linux_arm64.tar.gz'; sha256='bf7b2db319f2b9081671d1862e59581d1298a0015f6684acaa531d39995187cf' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v2.20.0/vultr-cli_v2.20.0_linux_arm32-v7.tar.gz'; sha256='dd0cb0500ff2b92c4bd9198c0c301f24a7c79696e15d1d3c58dbcd0e6d8a4331' ;; \
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
