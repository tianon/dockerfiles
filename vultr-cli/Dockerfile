#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.22

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 3.7.0

RUN set -eux; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86_64') url='https://github.com/vultr/vultr-cli/releases/download/v3.7.0/vultr-cli_v3.7.0_linux_amd64.tar.gz'; sha256='6990b0720efca4672f734dbad18caa28074b38cbe85e1e5877db7726f2095841' ;; \
		'armhf') url='https://github.com/vultr/vultr-cli/releases/download/v3.7.0/vultr-cli_v3.7.0_linux_arm32-v6.tar.gz'; sha256='ec6bf9209bc021cb315d2b99207cd3e6b16839e13480d2a8c695f0c16b871f9a' ;; \
		'armv7') url='https://github.com/vultr/vultr-cli/releases/download/v3.7.0/vultr-cli_v3.7.0_linux_arm32-v7.tar.gz'; sha256='505c921fc156692db604a967ef9524ce5bb22073b7ceb4069969746260080e1e' ;; \
		'aarch64') url='https://github.com/vultr/vultr-cli/releases/download/v3.7.0/vultr-cli_v3.7.0_linux_arm64.tar.gz'; sha256='98fbb1a2d63fe23b2de6a7f5d2b39b762bef04109d2c79a06155b76a06f0edf8' ;; \
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
