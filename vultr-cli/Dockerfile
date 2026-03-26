#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.9.2

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.9.2/vultr-cli_v3.9.2_linux_amd64.tar.gz'; sha256='6b04ab18d697c56f7c317926f0dd9ee5487d83c28d5b8eb5ff80016988d4eacf' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.9.2/vultr-cli_v3.9.2_linux_arm32-v6.tar.gz'; sha256='30bdf6a01f03a37da9c9e260d288ce70bae85e1545a894bbe461aee850ae1943' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.9.2/vultr-cli_v3.9.2_linux_arm32-v7.tar.gz'; sha256='5169ebbd73edb5c76e08f579a5fa2274ca7687c680ed2ba6709600ceeb0dd57b' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.9.2/vultr-cli_v3.9.2_linux_arm64.tar.gz'; sha256='17a5c2007c25747559edd15700ad376e85cdd94fafbb607e400d0ace34e09c90' ;; \
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
