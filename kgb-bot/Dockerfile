FROM debian:stretch-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		kgb-bot \
	&& rm -rf /var/lib/apt/lists/* \
	&& cp -v /etc/kgb-bot/kgb.conf /etc/kgb-bot/kgb.conf.orig

COPY kgb.conf /etc/kgb-bot/kgb.conf
# "/etc/kgb-bot/kgb.conf is world-readable" :'(
RUN chmod 0640 /etc/kgb-bot/kgb.conf

EXPOSE 5391

CMD [ "kgb-bot", "--foreground" ]
