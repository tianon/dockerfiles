FROM alpine:3.12

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 1.0.0
ENV VULTR_CLI_SHA256 3c31e9bc6c5ed6534f07c5aa8e79ae5fe27d04a6fd636b93629923d436e2486c

RUN set -eux; \
	wget -O vultr.tgz "https://github.com/vultr/vultr-cli/releases/download/v$VULTR_CLI_VERSION/vultr-cli_${VULTR_CLI_VERSION}_linux_64-bit.tar.gz"; \
	echo "$VULTR_CLI_SHA256 *vultr.tgz" | sha256sum -c -; \
	tar -xvf vultr.tgz -C /usr/local/bin; \
	rm vultr.tgz; \
	VULTR_API_KEY=fake vultr-cli version
