FROM node:4

# see https://github.com/vatesfr/xo/blob/a269af702992616f67b7bcf066eac0a1124ac8bf/doc/installation/manual_installation.md

#RUN apt-get update && apt-get install -y ruby-compass

WORKDIR /usr/src/xo/server

ENV XO_SERVER_REF v4.16.1
ENV XO_WEB_REF v4.16.0

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
