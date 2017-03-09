FROM alpine:3.4

RUN apk add --no-cache ca-certificates python3

ENV SPEEDTEST_VERSION 1.0.2

RUN pip3 install speedtest-cli==$SPEEDTEST_VERSION

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["speedtest-cli"]
