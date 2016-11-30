FROM node:4

# see https://xen-orchestra.com/docs/from_the_sources.html

WORKDIR /usr/src/xo/server

# https://github.com/vatesfr/xo-server/releases
ENV XO_SERVER_REF v5.4.0
# https://github.com/vatesfr/xo-web/releases
ENV XO_WEB_REF v5.4.0

RUN git clone -b "$XO_SERVER_REF" --depth 1 https://github.com/vatesfr/xo-server.git .
RUN git clone -b "$XO_WEB_REF" --depth 1 https://github.com/vatesfr/xo-web.git ../web

# tone down the NPM log level (default from image is "info")
ENV NPM_CONFIG_LOGLEVEL warn
# https://docs.npmjs.com/misc/config#loglevel

RUN set -x \
	&& npm install \
	&& npm run build

# workaround: Error: Cannot find module 'jquery' from '/usr/src/xo/web/node_modules/chartist-plugin-tooltip'
RUN set -x && cd ../web && npm install jquery

RUN set -x \
	&& cd ../web \
	&& npm install \
	&& npm run build

RUN set -x \
	&& sed \
		-e "s!#'/': '/path/to/xo-web/dist/'!'/': '../web/dist/'!" \
		-e "s!#uri: redis://.*!uri: 'redis://redis:6379'!" \
		sample.config.yaml > .xo-server.yaml \
	&& grep -q '../web/dist/' .xo-server.yaml \
	&& grep -q 'redis:6379' .xo-server.yaml

EXPOSE 80
CMD ["npm", "start"]
