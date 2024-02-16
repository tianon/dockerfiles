#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.0.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.0/vultr-cli_v3.0.0_linux_amd64.tar.gz'; sha256='0fc58ff584ab4c3ed2cb340c7656a480f8b397df54fbb12418ff163c56f5743d' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.0/vultr-cli_v3.0.0_linux_arm32-v6.tar.gz'; sha256='f962fb02fc9454994a2d39f47407f5a77fc4892126866b4aede91b947558ddf9' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.0/vultr-cli_v3.0.0_linux_arm32-v7.tar.gz'; sha256='e5ccab927afa2d45ab00376cffa728fbcb6ac19b774cab0e4e87f3fad8eb3fab' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.0.0/vultr-cli_v3.0.0_linux_arm64.tar.gz'; sha256='a82fd13da448640714dfaafe256a32a19b0cfcae5d4d2ee725061bff0b1fb12d' ;; \
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
