FROM python:2-slim

ENV GMVAULT_VERSION 1.9.1

RUN pip install gmvault==$GMVAULT_VERSION

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["gmvault"]
