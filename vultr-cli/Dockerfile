#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.20

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.3.1

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.3.1/vultr-cli_v3.3.1_linux_amd64.tar.gz'; sha256='4d4dae5d14337dca4c59ef7e8b629c5c47bb2c0a544aced9ae22583f440bfe9d' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.3.1/vultr-cli_v3.3.1_linux_arm32-v6.tar.gz'; sha256='71dba92270964408d4e96e657e300fb6fbf0b0803e85bfb500d3ad5fd327d4e6' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.3.1/vultr-cli_v3.3.1_linux_arm32-v7.tar.gz'; sha256='524afa3fb87f1c52e3ba7a9323b5937f211d173ab659b69862f3c6507aa8850b' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.3.1/vultr-cli_v3.3.1_linux_arm64.tar.gz'; sha256='1032633db439cec8aa4feb5464ad4e2e87871e4724a6d9919dbbad0680c7cdd5' ;; \
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
