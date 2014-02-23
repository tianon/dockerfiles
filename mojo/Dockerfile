FROM debian:testing

RUN apt-get update && apt-get install -yq curl

RUN apt-get update && apt-get install -yq perl build-essential

RUN curl -sLS https://raw.github.com/miyagawa/cpanminus/master/cpanm -o /usr/local/bin/cpanm && \
	chmod +x /usr/local/bin/cpanm

RUN cpanm Mojolicious

RUN apt-get update && apt-get install -yq libssl-dev

RUN cpanm EV IO::Socket::IP IO::Socket::SSL
