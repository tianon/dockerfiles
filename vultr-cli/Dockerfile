#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.22

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.5.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.5.0/vultr-cli_v3.5.0_linux_amd64.tar.gz'; sha256='db320a3d4f0ceef8a385313f7c2e7c472d73899ddf460b5201b0a557591c0d11' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.5.0/vultr-cli_v3.5.0_linux_arm32-v6.tar.gz'; sha256='b997330fad985e4261d6127884fd35c933a15110601ed9273ef95876c7052385' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.5.0/vultr-cli_v3.5.0_linux_arm32-v7.tar.gz'; sha256='91c3dbb669550e064b2b2a456bbc3e884f199cf6e8627c56dd9c5e62df25feba' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.5.0/vultr-cli_v3.5.0_linux_arm64.tar.gz'; sha256='1b88fdd9b9ad4508b3b2943ba7edae230d07ebbfee4735eb09fe2acc82eff552' ;; \
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
