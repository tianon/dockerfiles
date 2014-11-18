FROM debian:jessie

RUN apt-get update && apt-get install -y exim4-daemon-light

COPY set-exim4-update-conf /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 25
CMD ["exim", "-bd", "-v"]
