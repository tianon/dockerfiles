#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.1.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.1.0/vultr-cli_v3.1.0_linux_amd64.tar.gz'; sha256='ad2ce4a6672ff8deaf0981e892770230db70c43a1946d950fb7b10faf2d94a2d' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.1.0/vultr-cli_v3.1.0_linux_arm32-v6.tar.gz'; sha256='fa460c8c81351260c6791c4f7e251d60f757ac44bae870f6a2e74da84dd1d060' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.1.0/vultr-cli_v3.1.0_linux_arm32-v7.tar.gz'; sha256='5bcf5008f9c5df55007b2d9154ca33768203fa385fce08a7eaf7f5f584ddcfe8' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.1.0/vultr-cli_v3.1.0_linux_arm64.tar.gz'; sha256='7df5ce7b402ab80879760a0448a60e6f1c06c1284ae07aac4c2d50091ef7a66d' ;; \
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
