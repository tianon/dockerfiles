FROM tianon/debian:wheezy

# see https://github.com/vatesfr/xo/blob/master/installation.md

RUN apt-get update && apt-get install -q -y checkinstall curl g++ git make python

RUN curl -s 'http://nodejs.org/dist/node-latest.tar.gz' | tar -v -C /usr/src -xz && ln -s /usr/src/node-v* /usr/src/node
RUN cd /usr/src/node && ./configure && checkinstall

RUN mkdir /xo
RUN git clone git://github.com/vatesfr/xo-server.git /xo/xo-server
RUN git clone git://github.com/vatesfr/xo-web.git /xo/xo-web

RUN cd /xo/xo-server && npm install
RUN cd /xo/xo-server/public/http && for e in ../../../xo-web/public/*; do ln -s "$e"; done

# TODO use links to get a redis server/database instead (since that's where configuration actually goes)
RUN apt-get install -q -y redis-server

# TODO see note above about redis
CMD /etc/init.d/redis-server start && /xo/xo-server/xo-server

EXPOSE 80
