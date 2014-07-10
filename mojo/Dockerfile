FROM tianon/perl

RUN cpanm Mojolicious

RUN cpanm EV
RUN cpanm IO::Socket::IP
RUN cpanm --notest IO::Socket::SSL
# the tests for IO::Socket::SSL like to hang... :(
