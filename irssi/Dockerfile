FROM debian:testing

RUN apt-get update && apt-get install -yq ca-certificates irssi

RUN useradd --create-home user
USER user
ENV HOME /home/user
RUN mkdir -p $HOME/.irssi

ENV LANG C.UTF-8

CMD ["irssi"]
