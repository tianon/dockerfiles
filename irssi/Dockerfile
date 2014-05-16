FROM debian:jessie

RUN apt-get update && apt-get install -y ca-certificates irssi libwww-perl

RUN useradd --create-home user
USER user
ENV HOME /home/user
WORKDIR /home/user
RUN mkdir -p .irssi

ENV LANG C.UTF-8

CMD ["irssi"]
