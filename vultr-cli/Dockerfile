#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.18

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 2.17.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) vultrArch='arm64-bit' ;; \
		armhf)   vultrArch='armv6'     ;; \
		armv7)   vultrArch='armv7'     ;; \
		x86_64)  vultrArch='64-bit'    ;; \
		*) echo >&2 "error: unsupported arch: $apkArch"; exit 1 ;; \
	esac; \
	\
	filename="vultr-cli_${VULTR_CLI_VERSION}_linux_${vultrArch}.tar.gz"; \
	case "$filename" in \
		'vultr-cli_2.17.0_linux_armv7.tar.gz') sha256='3cf74a8327444c698a66d802667997887cb16f54574455968c828a9cb07bd1bc' ;; \
		'vultr-cli_2.17.0_linux_arm64-bit.tar.gz') sha256='47fe224b38aedeb6670a8e0c9f95a5c37c243327a8ff9fc161538b0979b58109' ;; \
		'vultr-cli_2.17.0_linux_armv6.tar.gz') sha256='6410c537503c3d180e81c16032ad6cc110ada6f513bf0ee8a219de8a33e6c9af' ;; \
		'vultr-cli_2.17.0_linux_64-bit.tar.gz') sha256='a9719d5761112486b13a1a7293b083e665e96c31ea0944303fa67448783bf2b6' ;; \
		*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
	esac; \
	wget -O vultr.tgz "https://github.com/vultr/vultr-cli/releases/download/v$VULTR_CLI_VERSION/$filename"; \
	echo "$sha256 *vultr.tgz" | sha256sum -c -; \
	\
	tar -xvf vultr.tgz -C /usr/local/bin; \
	rm vultr.tgz; \
	\
	VULTR_API_KEY=fake vultr-cli version

CMD ["vultr-cli", "--help"]
