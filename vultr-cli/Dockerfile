#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.18

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 2.18.2

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) vultrArch='arm64'    ;; \
		armhf)   vultrArch='arm32-v6' ;; \
		armv7)   vultrArch='arm32-v7' ;; \
		x86_64)  vultrArch='amd64'    ;; \
		*) echo >&2 "error: unsupported arch: $apkArch"; exit 1 ;; \
	esac; \
	\
	filename="${VULTR_CLI_VERSION}_linux_${vultrArch}.tar.gz"; \
	case "$filename" in \
		'2.18.2_linux_arm32-v6.tar.gz') sha256='0c990926d7b342d77ad3867a713739302951df1439a92102514bba1215d8fe9c' ;; \
		'2.18.2_linux_arm64.tar.gz') sha256='25bb6eba73696a12c9426f9acf4744f61819d638ac09a0668ef9887cc6ab6c30' ;; \
		'2.18.2_linux_arm32-v7.tar.gz') sha256='3a05671aeb8e8a6a8456fec4264174e88393f04e5bcf92b7f094f0d4e0a41f4d' ;; \
		'2.18.2_linux_amd64.tar.gz') sha256='4807964caf2dd34f2a44522b64deac18f1c985422a10d52ea60ba668fae49ed0' ;; \
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
