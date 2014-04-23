FROM debian:testing

RUN apt-get update && apt-get install -yq ca-certificates irssi

ENV HOME /root
RUN mkdir -p $HOME/.irssi

ENV LANG C.UTF-8

CMD ["irssi"]
