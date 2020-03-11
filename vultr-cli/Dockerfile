FROM alpine:3.11

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 0.2.0
ENV VULTR_CLI_SHA256 abc3d31c824b1a75c689ade78bb708c8737bb39129b2b319b1c0b7cb41055be6

RUN set -eux; \
	wget -O vultr.tgz "https://github.com/vultr/vultr-cli/releases/download/v$VULTR_CLI_VERSION/vultr-cli_${VULTR_CLI_VERSION}_linux_64-bit.tar.gz"; \
	echo "$VULTR_CLI_SHA256 *vultr.tgz" | sha256sum -c -; \
	tar -xvf vultr.tgz -C /usr/local/bin; \
	rm vultr.tgz; \
	VULTR_API_KEY=fake vultr-cli version
