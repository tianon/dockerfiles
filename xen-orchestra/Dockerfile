# see https://xen-orchestra.com/docs/from_the_sources.html

FROM node:8-slim

RUN set -eux; \
	yarn global add node-gyp@3.5; \
	node-gyp --version

WORKDIR /usr/src/xo/packages/xo-server

# https://github.com/vatesfr/xen-orchestra/releases
ENV XO_VERSION xo-server-v5.30.1

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
	sed \
		-e "s!#'/': '/path/to/xo-web/dist/'!'/': '../xo-web/dist/'!" \
		-e "s!#uri: redis://.*!uri: 'redis://redis:6379'!" \
		sample.config.yaml > .xo-server.yaml \
	; \
	grep -q '../xo-web/dist/' .xo-server.yaml; \
	grep -q 'redis:6379' .xo-server.yaml

EXPOSE 80
CMD ["yarn", "start"]
