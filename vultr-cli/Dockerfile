FROM alpine:3.10

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 0.1.0

RUN set -eux; \
	wget -O vultr.tgz "https://github.com/vultr/vultr-cli/releases/download/v$VULTR_CLI_VERSION/vultr-cli_linux_amd64.tar.gz"; \
	tar -xvf vultr.tgz -C /usr/local/bin; \
	rm vultr.tgz; \
	mv /usr/local/bin/vultr-cli_linux_amd64 /usr/local/bin/vultr-cli; \
	VULTR_API_KEY=fake vultr-cli version
