FROM tianon/perl

RUN cpanm Mojolicious

RUN apt-get update && apt-get install -yq libssl-dev

RUN cpanm EV IO::Socket::IP IO::Socket::SSL
