FROM alpine:3.8

RUN apk add --no-cache ca-certificates python3

ENV SPEEDTEST_VERSION 1.0.2

RUN pip3 install speedtest-cli==$SPEEDTEST_VERSION

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["speedtest-cli"]
