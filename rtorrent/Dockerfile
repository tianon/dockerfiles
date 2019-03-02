FROM debian:stretch-slim

RUN useradd --create-home user

RUN apt-get update && apt-get install -y --no-install-recommends rtorrent && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /torrents/session \
	&& touch /torrents/.rtorrent.rc \
	&& chown -R user:user /torrents
VOLUME /torrents

COPY --chown=user:user rtorrent.rc /home/user/.rtorrent.rc

USER user
CMD ["rtorrent"]
