FROM debian:stretch-slim

RUN useradd --create-home user

RUN apt-get update && apt-get install -y --no-install-recommends rtorrent && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /torrents/session \
	&& touch /torrents/.rtorrent.rc \
	&& chown -R user:user /torrents
VOLUME /torrents

COPY rtorrent.rc /home/user/.rtorrent.rc
RUN chown -R user:user /home/user

USER user
CMD ["rtorrent"]
