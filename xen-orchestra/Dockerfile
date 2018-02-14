# see https://xen-orchestra.com/docs/from_the_sources.html

FROM node:6

RUN set -ex; \
	yarn global add node-gyp@3.5; \
	node-gyp --version

WORKDIR /usr/src/xo/server

# https://github.com/vatesfr/xen-orchestra/releases
ENV XO_SERVER_REF v5.6.4
ENV XO_WEB_REF v5.6.3

RUN git clone -b "xo-server/$XO_SERVER_REF" --depth 1 https://github.com/vatesfr/xen-orchestra.git .
RUN git clone -b "xo-web/$XO_WEB_REF" --depth 1 https://github.com/vatesfr/xen-orchestra.git ../web

# tone down the NPM log level (default from image is "info")
ENV NPM_CONFIG_LOGLEVEL warn
# https://docs.npmjs.com/misc/config#loglevel

RUN set -ex; \
	yarn

RUN set -ex; \
	cd ../web; \
	yarn

RUN set -x \
	&& sed \
		-e "s!#'/': '/path/to/xo-web/dist/'!'/': '../web/dist/'!" \
		-e "s!#uri: redis://.*!uri: 'redis://redis:6379'!" \
		sample.config.yaml > .xo-server.yaml \
	&& grep -q '../web/dist/' .xo-server.yaml \
	&& grep -q 'redis:6379' .xo-server.yaml

EXPOSE 80
CMD ["yarn", "start"]
