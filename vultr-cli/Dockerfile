#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.20

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.4.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.4.0/vultr-cli_v3.4.0_linux_amd64.tar.gz'; sha256='3c9b1c7c4762dd0fc6354feb2867fe47d6b394dce9e558df1ed2c7e3e0ad320e' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.4.0/vultr-cli_v3.4.0_linux_arm32-v6.tar.gz'; sha256='b0ba88f8dec9e592b9c709b7a7285568a2a994dad62813b52c9e1b06ef95f544' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.4.0/vultr-cli_v3.4.0_linux_arm32-v7.tar.gz'; sha256='3239c798b4128f0dfcfc0eeb0c63084189a3f22a32cbe28f9f643af625731bdf' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.4.0/vultr-cli_v3.4.0_linux_arm64.tar.gz'; sha256='cf46b1d0f27990a0c7c07561eabfd8123487ac71d774bfb73221793743a05de2' ;; \
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
