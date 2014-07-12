FROM python:3

RUN git clone https://github.com/sivel/speedtest-cli.git /usr/src/speedtest-cli
WORKDIR /usr/src/speedtest-cli
RUN python setup.py install

CMD ["speedtest-cli"]
