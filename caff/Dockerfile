FROM debian:sid

RUN groupadd -g 1000 user \
	&& useradd --create-home -d /home/user -g user -u 1000 user

RUN apt-get update && apt-get install -y signing-party ssmtp

USER user
ENV HOME /home/user
WORKDIR /home/user

RUN mkdir -p .caff/gnupghome \
	&& chmod 700 .caff/gnupghome \
	&& { \
		echo 'personal-digest-preferences SHA512'; \
		echo 'cert-digest-algo SHA512'; \
		echo 'default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed'; \
		echo 'keyid-format long'; \
	} > .caff/gnupghome/gpg.conf

COPY --chown=user:user caffrc /home/user/.caffrc

ENTRYPOINT ["caff"]
CMD []
