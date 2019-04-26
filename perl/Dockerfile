FROM perl:5.28

# secure by default ♥ (thanks to sri!)
ENV PERL_CPANM_OPT --verbose --mirror https://cpan.metacpan.org --mirror-only
RUN cpanm Digest::SHA Module::Signature && rm -rf ~/.cpanm
ENV PERL_CPANM_OPT $PERL_CPANM_OPT --verify

# reinstall cpanm itself, for good measure
RUN cpanm App::cpanminus && rm -rf ~/.cpanm
