FROM perl:5.38

# secure by default ♥ (thanks to sri!)
ENV PERL_CPANM_OPT --verbose --mirror https://cpan.metacpan.org --mirror-only
# gpg: verify signatures failed: Unknown system error
# ! Verifying CHECKSUMS signature failed:
# ! Failed to fetch distribution IO-Socket-IP-0.41
#RUN cpanm Digest::SHA Module::Signature && rm -rf ~/.cpanm
#ENV PERL_CPANM_OPT $PERL_CPANM_OPT --verify

# reinstall cpanm itself, for good measure
#RUN cpanm App::cpanminus && rm -rf ~/.cpanm
