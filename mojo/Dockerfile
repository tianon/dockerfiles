FROM tianon/perl

# TODO pin a version
RUN cpanm Mojolicious && rm -rf ~/.cpanm

# TODO pin versions
RUN cpanm EV && rm -rf ~/.cpanm
RUN cpanm --notest IO::Socket::IP && rm -rf ~/.cpanm
# the tests for IO::Socket::IP hit some internet resources ("Failed test 'defined $socket for cpanidx.org:80'", "error was Name or service not known")
RUN cpanm --notest IO::Socket::SSL && rm -rf ~/.cpanm
# the tests for IO::Socket::SSL like to hang... :(

# https://metacpan.org/pod/release/SRI/Mojolicious-7.94/lib/Mojo/IOLoop.pm#DESCRIPTION
ENV LIBEV_FLAGS 4
# epoll (Linux)
