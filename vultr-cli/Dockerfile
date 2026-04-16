#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.10.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.10.0/vultr-cli_v3.10.0_linux_amd64.tar.gz'; sha256='ec44b044a89ded0791cce364ca9ac82fbbc79f6fbc1140686919c6d5f7c0749f' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.10.0/vultr-cli_v3.10.0_linux_arm32-v6.tar.gz'; sha256='61889b00a91a2dfaf6a37bdcd6274f8a97b7f6f511f3c3598491fce4750bb2a0' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.10.0/vultr-cli_v3.10.0_linux_arm32-v7.tar.gz'; sha256='99d68fa304cbc97ed0f3b0bb809a20c54377bb9548583d63845bc5d0906f5832' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.10.0/vultr-cli_v3.10.0_linux_arm64.tar.gz'; sha256='04e148c9e92429a1283d533085e98470794797612349801b6e823962a2eb192f' ;; \
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
