FROM debian:wheezy

RUN apt-get update && apt-get install -yq rtorrent

RUN mkdir -p /torrents/session && touch /torrents/.rtorrent.rc
VOLUME /torrents

ADD rtorrent.rc /.rtorrent.rc

CMD ["rtorrent"]
