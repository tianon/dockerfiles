FROM node:12-alpine3.12

# https://www.npmjs.com/package/@bitwarden/cli?activeTab=versions
ENV BITWARDEN_VERSION 1.11.0

RUN set -eux; \
	yarn global add "@bitwarden/cli@$BITWARDEN_VERSION"

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["--help"]
