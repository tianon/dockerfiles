FROM debian:jessie

RUN apt-get update && apt-get install -y curl gcc less make

RUN mkdir -p /usr/src/perl \
	&& curl -SL http://www.cpan.org/src/5.0/perl-5.20.0.tar.gz \
		| tar -xz --strip-components=1 -C /usr/src/perl

WORKDIR /usr/src/perl
RUN ./Configure -der
RUN make
RUN make test
RUN make install

ENV PERL_CPANM_OPT --verbose
RUN curl -SL http://cpanmin.us | perl - App::cpanminus
