#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 2.22.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v2.22.0/vultr-cli_v2.22.0_linux_amd64.tar.gz'; sha256='13b1f90be28ae87dbccbeb8ab1960245eca0731956872fe18a98750aca3bc26e' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v2.22.0/vultr-cli_v2.22.0_linux_arm32-v6.tar.gz'; sha256='38ce9b1b42ed2aa492f5baf9016793437a20384bc651ae8603fe5cc94dce7b4c' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v2.22.0/vultr-cli_v2.22.0_linux_arm32-v7.tar.gz'; sha256='102f1bdcbd4f105632ce2cd8fae24e950566940589664042eef8f735fa13bc52' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v2.22.0/vultr-cli_v2.22.0_linux_arm64.tar.gz'; sha256='82a9298a2484e7d8af0c92365e2a687c1a26761ebd1d420765f03ed0c08d3167' ;; \
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
