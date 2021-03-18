FROM alpine:3.13

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 2.3.0
ENV VULTR_CLI_SHA256 2cd37a52eedb3f3d70f1c66a57295c013b952fedeb27db63a15f4f4679151a45

RUN set -eux; \
	wget -O vultr.tgz "https://github.com/vultr/vultr-cli/releases/download/v$VULTR_CLI_VERSION/vultr-cli_${VULTR_CLI_VERSION}_linux_64-bit.tar.gz"; \
	echo "$VULTR_CLI_SHA256 *vultr.tgz" | sha256sum -c -; \
	tar -xvf vultr.tgz -C /usr/local/bin; \
	rm vultr.tgz; \
	VULTR_API_KEY=fake vultr-cli version
