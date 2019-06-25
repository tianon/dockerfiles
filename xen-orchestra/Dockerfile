# see https://xen-orchestra.com/docs/from_the_sources.html

FROM node:8-slim

# https://github.com/nodejs/node-gyp/releases
RUN set -eux; \
	yarn global add node-gyp@5.0.1; \
	node-gyp --version

WORKDIR /usr/src/xo/packages/xo-server

# https://github.com/vatesfr/xen-orchestra/releases
ENV XO_VERSION xo-server-v5.43.0

RUN set -eux; \
	cd /usr/src/xo; \
	wget -O xo.tgz "https://github.com/vatesfr/xen-orchestra/archive/$XO_VERSION.tar.gz"; \
	tar -xvf xo.tgz --strip-components=1; \
	rm xo.tgz

RUN set -eux; \
	cd /usr/src/xo; \
	yarn; \
	yarn build

RUN set -eux; \
	mkdir /etc/xo-server; \
	sed \
#		-e "s!#'/' = '/path/to/xo-web/dist/'!'/' = '../xo-web/dist/'!" \
		-e "s!#uri = 'redis://.*'!uri = 'redis://redis:6379'!" \
		sample.config.toml > /etc/xo-server/config.toml \
	; \
	grep -vE '^#' config.toml | grep '../xo-web/dist'; \
	grep 'redis:6379' /etc/xo-server/config.toml

EXPOSE 80
CMD ["yarn", "start"]
