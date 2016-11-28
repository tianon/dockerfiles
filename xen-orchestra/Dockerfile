FROM node:5

# see https://xen-orchestra.com/docs/from_the_sources.html

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential libpng-dev python-minimal \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/xo/server

ENV XO_SERVER_REF v5.1.1
ENV XO_WEB_REF v5.1.1

RUN git clone -b "$XO_SERVER_REF" --depth 1 https://github.com/vatesfr/xo-server.git .
RUN git clone -b "$XO_WEB_REF" --depth 1 https://github.com/vatesfr/xo-web.git ../web

RUN set -x \
	&& npm install \
	&& npm run build

RUN set -x \
	&& cd ../web \
	&& npm install \
	&& npm run build

RUN sed " \
		s!#'/': '/path/to/xo-web/dist/'!'/': '../web/dist/'!; \
		s!#uri: ''!uri: 'redis://redis:6379'!; \
	" sample.config.yaml > .xo-server.yaml

EXPOSE 80
CMD ["npm", "start"]
