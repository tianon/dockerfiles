FROM alpine:3.10

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 0.1.0
ENV VULTR_CLI_SHA256 f55a7f9d1782e353a7f8776434bd4c34be962ca8d6364ff6a69687e2e9b65c36

RUN set -eux; \
	wget -O vultr.tgz "https://github.com/vultr/vultr-cli/releases/download/v$VULTR_CLI_VERSION/vultr-cli_linux_amd64.tar.gz"; \
	echo "$VULTR_CLI_SHA256 *vultr.tgz" | sha256sum -c -; \
	tar -xvf vultr.tgz -C /usr/local/bin; \
	rm vultr.tgz; \
	mv /usr/local/bin/vultr-cli_linux_amd64 /usr/local/bin/vultr-cli; \
	VULTR_API_KEY=fake vultr-cli version
