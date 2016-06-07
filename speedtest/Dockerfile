FROM alpine:3.4

RUN apk add --no-cache ca-certificates python3

ENV SPEEDTEST_CLI_VERSION 0.3.4

RUN pip3 install speedtest-cli==$SPEEDTEST_CLI_VERSION

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["speedtest-cli"]
