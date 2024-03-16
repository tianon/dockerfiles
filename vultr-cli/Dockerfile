#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.0.3

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.3/vultr-cli_v3.0.3_linux_amd64.tar.gz'; sha256='9e7d0005e90e467bf0f2c445b2a98b6962bba037773f6558f375540173223c2c' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.3/vultr-cli_v3.0.3_linux_arm32-v6.tar.gz'; sha256='13119b82af6b2178a6ad3423133362cfcda7af31b2e64a654b119fe13eda2117' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.3/vultr-cli_v3.0.3_linux_arm32-v7.tar.gz'; sha256='6769ef3e53f55644e881e1a9685d37a59db55131556c8700e4ecf5521f9c70ed' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.3/vultr-cli_v3.0.3_linux_arm64.tar.gz'; sha256='b911785e2e7b60538c18cb596246e5f77fa5cc5f6851cf72cbc559101ced7f80' ;; \
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
