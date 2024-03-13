#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.0.2

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.2/vultr-cli_v3.0.2_linux_amd64.tar.gz'; sha256='5ef70648b733bb7eba700074e55d85a71b85a61621dd64662e695b348e587210' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.2/vultr-cli_v3.0.2_linux_arm32-v6.tar.gz'; sha256='80bf6748f72119c519c18bb62a7187f9565827795a7339821cccee6532899bd6' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.2/vultr-cli_v3.0.2_linux_arm32-v7.tar.gz'; sha256='d57f081e7ad99ef0be265c4ce198043e877bc6a585a91bddbee286185896b69c' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.2/vultr-cli_v3.0.2_linux_arm64.tar.gz'; sha256='13906a1a50229f878f2651e65edafa353bfb9da118f67bb0bd537ab307e56bb6' ;; \
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
