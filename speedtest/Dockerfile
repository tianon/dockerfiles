FROM alpine:3.2

RUN apk add --update \
		ca-certificates \
		python3 \
	&& rm -rf /var/cache/apk/*

ENV SPEEDTEST_CLI_VERSION 0.3.4

RUN pip3 install speedtest-cli==$SPEEDTEST_CLI_VERSION

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["speedtest-cli"]
