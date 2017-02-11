FROM debian:jessie-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		kgb-bot \
	&& rm -rf /var/lib/apt/lists/*

COPY kgb.conf /etc/kgb-bot/kgb.conf

EXPOSE 5391

CMD [ "kgb-bot", "--foreground" ]
