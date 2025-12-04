#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.8.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.8.0/vultr-cli_v3.8.0_linux_amd64.tar.gz'; sha256='72da8beec8a27c78193f2931f281cc3853113c99bfe8dc2aa21b5fb5e6f08c6b' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.8.0/vultr-cli_v3.8.0_linux_arm32-v6.tar.gz'; sha256='fc41988a72890ef89a1773805693b85a99f5fd83d2a8361c156901997c5c33dd' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.8.0/vultr-cli_v3.8.0_linux_arm32-v7.tar.gz'; sha256='bcb5ff52edc601a88ef6fc36397d2098962280afe3fa31e8c5bf64506aadb39d' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.8.0/vultr-cli_v3.8.0_linux_arm64.tar.gz'; sha256='e66f23fb103b45e0bb4b014ebb685d8aa0189e3d520f7470a2aae81a1af818d5' ;; \
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
