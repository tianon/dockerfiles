#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.15

RUN apk add --no-cache ca-certificates

# https://github.com/vultr/vultr-cli/releases
ENV VULTR_CLI_VERSION 2.12.2
ENV VULTR_CLI_SHA256 28fd4d4eb960e381d4b9840fe6ca50cef0937efdcf09b12fe9f174c05379a54a
# TODO multiple architectures (at least "arm64" is also supported)

RUN set -eux; \
	wget -O vultr.tgz "https://github.com/vultr/vultr-cli/releases/download/v$VULTR_CLI_VERSION/vultr-cli_${VULTR_CLI_VERSION}_linux_64-bit.tar.gz"; \
	echo "$VULTR_CLI_SHA256 *vultr.tgz" | sha256sum -c -; \
	tar -xvf vultr.tgz -C /usr/local/bin; \
	rm vultr.tgz; \
	VULTR_API_KEY=fake vultr-cli version

CMD ["vultr-cli", "--help"]
