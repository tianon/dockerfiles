FROM node

# see https://github.com/vatesfr/xo/blob/master/installation.md

RUN apt-get update && apt-get install -y ruby-compass

ENV XO_REF v3.4.0

RUN mkdir -p /usr/src/xo
WORKDIR /usr/src/xo
RUN git clone -b $XO_REF git://github.com/vatesfr/xo-server.git
RUN git clone -b $XO_REF git://github.com/vatesfr/xo-web.git

RUN cd xo-server && npm install
RUN cd xo-server && cp config/local.yaml.dist config/local.yaml

RUN cd xo-web && npm install
RUN cd xo-web && ./gulp --production

EXPOSE 80
CMD ["./xo-server/xo-server"]
