FROM python:3-slim

ENV SPEEDTEST_CLI_VERSION 0.3.2

RUN pip install speedtest-cli==$SPEEDTEST_CLI_VERSION

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["speedtest-cli"]
