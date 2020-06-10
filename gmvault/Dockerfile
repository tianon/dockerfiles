# for Python 2
FROM alpine:3.11

RUN apk add --no-cache bash py2-pip

ENV GMVAULT_VERSION 1.9.1

RUN pip install --no-cache-dir gmvault==$GMVAULT_VERSION

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["gmvault"]
