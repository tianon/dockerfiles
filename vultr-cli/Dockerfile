FROM alpine:3.13

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 2.5.0
ENV VULTR_CLI_SHA256 62c2a6ee0dc6e919142c7ff5d50654398c9bac1ca00c9c552cd1165fae90833f

RUN set -eux; \
	wget -O vultr.tgz "https://github.com/vultr/vultr-cli/releases/download/v$VULTR_CLI_VERSION/vultr-cli_${VULTR_CLI_VERSION}_linux_64-bit.tar.gz"; \
	echo "$VULTR_CLI_SHA256 *vultr.tgz" | sha256sum -c -; \
	tar -xvf vultr.tgz -C /usr/local/bin; \
	rm vultr.tgz; \
	VULTR_API_KEY=fake vultr-cli version
